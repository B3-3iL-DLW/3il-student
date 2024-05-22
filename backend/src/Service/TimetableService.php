<?php

namespace App\Service;

use App\Entity\DaySchedule;
use App\Entity\Event;
use App\Entity\EventHours;
use App\Entity\WeekSchedule;
use App\Service\Scrapper\ClassesScraperService;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Contracts\HttpClient\Exception\ClientExceptionInterface;
use Symfony\Contracts\HttpClient\Exception\RedirectionExceptionInterface;
use Symfony\Contracts\HttpClient\Exception\ServerExceptionInterface;
use Symfony\Contracts\HttpClient\Exception\TransportExceptionInterface;

class TimetableService
{
    private ClassesScraperService $classesScraperService;
    private string $schedule_url;
    private EntityManagerInterface $entityManager;
    private XMLService $xmlService;

    public function __construct(ClassesScraperService $classesScraperService, string $schedule_url, XMLService $xmlService, EntityManagerInterface $entityManager)
    {
        $this->classesScraperService = $classesScraperService;
        $this->schedule_url = $schedule_url;
        $this->xmlService = $xmlService;
        $this->entityManager = $entityManager;
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

        $changes = false;

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
                $daySchedule->setDate(\DateTime::createFromFormat('d/m/Y', $day['Date'])->setTime(0, 0));
                $daySchedule->setJour($weekDayNumber);
                $daySchedule->setId(random_int(0, 1000000));

                $daySchedule->setWeekSchedule($weekSchedule);

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
                        $event->setEventDate(\DateTimeImmutable::createFromFormat('d/m/Y', $day['Date'])->setTime(0, 0));
                        $event->setActivite($creneau['Activite'] ?? 'Pas cours');
                        $event->setId($creneau['Id'] ?? 0);
                        $event->setCouleur($creneau['Couleur'] ?? '#000000');
                        $event->setHoraire($eventHours);
                        $event->setSalle($creneau['Salles'] ?? '');
                        $event->setRepas('3' === $creneau['Creneau'] && empty($creneau['Activite']));
                        $event->setVisio(str_contains($creneau['Salles'] ?? null, 'Teams'));
                        $event->setEval(str_contains($creneau['Activite'] ?? null, ' EI') || str_contains($creneau['Activite'] ?? null, ' DS'));
                        $daySchedule->addEvent($event);
                        // Vérifiez si l'événement existe déjà avec son creneau et sa date du jour
                        $existingEvent = $this->entityManager->getRepository(Event::class)->findOneBy([
                            'creneau' => $creneau['Creneau'],
                            'event_date' => \DateTimeImmutable::createFromFormat('d/m/Y', $day['Date'])->setTime(0, 0),
                        ]);

                        if ($existingEvent) {
                            // Si l'événement existe déjà, fusionnez les modifications
                            if ($existingEvent->getActivite() !== $event->getActivite()
                                || $existingEvent->getCouleur() !== $event->getCouleur()
                                || $existingEvent->getSalle() !== $event->getSalle()
                                || $existingEvent->isRepas() !== $event->isRepas()
                                || $existingEvent->isVisio() !== $event->isVisio()
                                || $existingEvent->getEval() !== $event->getEval()) {
                                // On le met à jour avec les nouvelles valeurs
                                $existingEvent->setActivite($event->getActivite());
                                $existingEvent->setCouleur($event->getCouleur());
                                $existingEvent->setSalle($event->getSalle());
                                $existingEvent->setRepas($event->isRepas());
                                $existingEvent->setVisio($event->isVisio());
                                $existingEvent->setEval($event->getEval());
                                $this->entityManager->persist($existingEvent);
                                $changes = true;
                            }
                        } else {
                            $this->entityManager->persist($event);
                            $this->entityManager->flush();
                        }

                    }
                }

                $weekSchedule->addDaySchedule($daySchedule);
                // On persiste les jours de la semaine en base de données
            }
            $weeks[] = $weekSchedule;
        }
        $this->entityManager->flush();

        return ['weeks' => $weeks, 'changes' => $changes];
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
