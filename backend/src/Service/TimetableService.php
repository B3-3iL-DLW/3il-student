<?php

namespace App\Service;

use App\Entity\DaySchedule;
use App\Entity\Event;
use App\Entity\EventHours;
use App\Entity\WeekSchedule;
use Symfony\Contracts\HttpClient\Exception\ClientExceptionInterface;
use Symfony\Contracts\HttpClient\Exception\RedirectionExceptionInterface;
use Symfony\Contracts\HttpClient\Exception\ServerExceptionInterface;
use Symfony\Contracts\HttpClient\Exception\TransportExceptionInterface;

class TimetableService
{
    private ClassesScraperService $classesScraperService;
    private string $schedule_url;
    private XMLService $xmlService;

    public function __construct(ClassesScraperService $classesScraperService, string $schedule_url, XMLService $xmlService)
    {
        $this->classesScraperService = $classesScraperService;
        $this->schedule_url = $schedule_url;
        $this->xmlService = $xmlService;
    }

    /**
     * Get the xml file for a given class.
     *
     * @throws TransportExceptionInterface
     */
    public function getXmlFile(string $classParam): ?string
    {
        $classesList = $this->classesScraperService->scrapeClasses();
        foreach ($classesList as $class) {
            if ($class->getName() === $classParam) {
                $encodedClassFile = str_replace(' ', '%20', $class->getFile());

                return $this->schedule_url.$encodedClassFile;
            }
        }

        return null;
    }

    /**
     * Define the time slots for the timetable.
     */
    public function defineCreneaux(): array
    {
        return [
            '1' => ['start' => '8h30', 'end' => '10h'],
            '2' => ['start' => '10h30', 'end' => '12h'],
            '3' => ['start' => '12h', 'end' => '13h30'],
            '4' => ['start' => '13h30', 'end' => '15h'],
            '5' => ['start' => '15h15', 'end' => '16h45'],
            '6' => ['start' => '17h', 'end' => '18h30'],
        ];
    }

    /**
     * Put the parsed data into entity objects.
     */
    public function parseData(array $parsedData): array
    {
        $creneaux = $this->defineCreneaux();
        $weeks = [];


        foreach ($parsedData['GROUPE']['PLAGES']['SEMAINE'] as $week) {
            $weekSchedule = new WeekSchedule();
            $weekSchedule->setId($week['SemId']);
            $weekSchedule->setCode($week['SemCod']);

            foreach ($week['JOUR'] as $day) {
                $weekDayNumber = date('N', strtotime(str_replace('/', '-', $day['Date'])));

                if ($weekDayNumber > 5) {
                    continue;
                }

                $daySchedule = new DaySchedule();
                $daySchedule->setDate(\DateTime::createFromFormat('d/m/Y', $day['Date']));
                $daySchedule->setJour($weekDayNumber);
                $daySchedule->setId(random_int(0, 1000000));

                foreach ($day['CRENEAU'] as $creneau) {
                    if (isset($creneaux[$creneau['Creneau']])) {

                        // Verification si la salle est un array vide car le XML de 3il est nul
                        if (is_array($creneau['Salles'] ?? '')) {
                            $creneau['Salles'] = '';
                        }

                        $eventHours = new EventHours();
                        $eventHours->setStartAt($creneaux[$creneau['Creneau']]['start']);
                        $eventHours->setEndAt($creneaux[$creneau['Creneau']]['end']);
                        $eventHours->setId(random_int(0, 1000000));
                        $event = new Event();
                        $event->setCreneau($creneau['Creneau']);
                        $event->setActivite($creneau['Activite'] ?? 'Pas cours');
                        $event->setId($creneau['Id'] ?? 0);
                        $event->setCouleur($creneau['Couleur'] ?? '#000000');
                        $event->setHoraire($eventHours);
                        $event->setSalle($creneau['Salles'] ?? '');
                        $event->setRepas('3' === $creneau['Creneau'] && empty($creneau['Activite']));
                        $event->setVisio(str_contains($creneau['Salles'] ?? null, 'Teams'));
                        $event->setEval(str_contains($creneau['Activite'] ?? null, ' EI'));

                        $daySchedule->addEvent($event);
                    }
                }

                $weekSchedule->addDaySchedule($daySchedule);
            }
            $weeks[] = $weekSchedule;
        }

        return $weeks;
    }

    /**
     * Fetch and parse the xml file.
     *
     * @param string $xmlUrl The url of the xml file
     *
     * @throws TransportExceptionInterface
     * @throws ServerExceptionInterface
     * @throws RedirectionExceptionInterface
     * @throws ClientExceptionInterface
     */
    public function fetchAndParseData(string $xmlUrl): array
    {
        $xmlContent = $this->xmlService->fetchXmlData($xmlUrl);
        $parsedXml = $this->xmlService->parseXmlData($xmlContent);

        return $this->parseData($parsedXml);
    }
}
