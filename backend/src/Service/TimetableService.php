<?php

namespace App\Service;

use App\Entity\DaySchedule;
use App\Entity\Event;
use App\Entity\EventHours;
use App\Entity\Timetable;
use App\Entity\WeekSchedule;
use Symfony\Component\HttpClient\HttpClient;
use Symfony\Contracts\HttpClient\Exception\ClientExceptionInterface;
use Symfony\Contracts\HttpClient\Exception\RedirectionExceptionInterface;
use Symfony\Contracts\HttpClient\Exception\ServerExceptionInterface;
use Symfony\Contracts\HttpClient\Exception\TransportExceptionInterface;

class TimetableService
{

    private $classesScraperService;
    private $schedule_url;

    public function __construct(ClassesScraperService $classesScraperService, string $schedule_url)
    {
        $this->classesScraperService = $classesScraperService;
        $this->schedule_url = $schedule_url;
    }


    public function getXmlFile(string $classParam): ?string
    {
        $classesList = $this->classesScraperService->scrapeClasses();
        foreach ($classesList as $class) {
            if ($class['name'] === $classParam) {
                $encodedClassFile = str_replace(' ', '%20', $class['file']);
                return $this->schedule_url . $encodedClassFile;
            }
        }

        return null;
    }

    public function defineCreneaux(): array
    {
        return [
            "1" => ["start" => "8h30", "end" => "10h"],
            "2" => ["start" => "10h30", "end" => "12h"],
            "3" => ["start" => "12h", "end" => "13h30"],
            "4" => ["start" => "13h30", "end" => "15h"],
            "5" => ["start" => "15h15", "end" => "16h45"],
            "6" => ["start" => "17h", "end" => "18h30"]
        ];
    }


    public function filterParsedData(array $parsedData): Timetable
    {
        $creneaux = $this->defineCreneaux();
        $timetable = new Timetable();
        $timetable->setId(random_int(0, 1000000));

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
                        $eventHours = new EventHours();
                        $eventHours->setStartAt($creneaux[$creneau['Creneau']]['start']);
                        $eventHours->setEndAt($creneaux[$creneau['Creneau']]['end']);

                        $event = new Event();
                        $event->setCreneau($creneau['Creneau']);
                        $event->setActivite($creneau['Activite'] ?? "Pas cours");
                        $event->setId($creneau['Id'] ?? 0);
                        $event->setCouleur($creneau['Couleur'] ?? "#000000");
                        $event->setHoraire($eventHours);
                        $event->setSalle($creneau['Salles'] ?? "");
                        $event->setVisio(str_contains($creneau['Salles'] ?? null, 'Teams'));

                        $daySchedule->addEvent($event);

                    }
                }

                $weekSchedule->addDaySchedule($daySchedule);
            }
            $timetable->addWeek($weekSchedule);
        }

        return $timetable;
    }

    /**
     * @throws TransportExceptionInterface
     * @throws ServerExceptionInterface
     * @throws RedirectionExceptionInterface
     * @throws ClientExceptionInterface
     */
    public function fetchXmlData(string $xmlUrl): string
    {
        $httpClient = HttpClient::create();
        $content = $httpClient->request('GET', $xmlUrl)->getContent();
        return $content;
    }

    public function parseXmlData(string $xmlContent): array
    {
        $xmlHash = simplexml_load_string($xmlContent);
        return json_decode(json_encode($xmlHash), true);
    }


    /**
     * @throws TransportExceptionInterface
     * @throws ServerExceptionInterface
     * @throws RedirectionExceptionInterface
     * @throws ClientExceptionInterface
     */
    public function fetchAndParseData(string $xmlUrl): Timetable
    {
        $xmlContent = $this->fetchXmlData($xmlUrl);
        $parsedData = $this->parseXmlData($xmlContent);
        return $this->filterParsedData($parsedData);
    }
}
