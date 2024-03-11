<?php

namespace App\Service;

use Symfony\Component\HttpClient\HttpClient;

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


    public function filterParsedData(array $parsedData): array
    {
        $creneaux = $this->defineCreneaux();
        $filteredData = [];

        foreach ($parsedData['GROUPE']['PLAGES']['SEMAINE'] as $week) {
            foreach ($week['JOUR'] as $day) {
                // Remove the slashes from the date and convert it to a date object
                $weekDayNumber = date('N', strtotime(str_replace('/', '-', $day['Date'])));

                if ($weekDayNumber > 5) {
                    continue;
                }

                $jourData = [];
                // Overwrite the day number with the actual day name because 3iL is weird
                $jourData['jour'] = $weekDayNumber;
                $jourData['date'] = $day['Date'];

                $allCreneauxNull = true;

                foreach ($day['CRENEAU'] as $creneau) {
                    if (isset($creneaux[$creneau['Creneau']])) {
                        if (isset($creneau['Id'])) {
                            if ($creneau['Id'] !== null) {
                                $allCreneauxNull = false;
                            }
                        }
                    }
                }

                if ($allCreneauxNull) {
                    continue;
                }

                foreach ($day['CRENEAU'] as $creneau) {
                    if (isset($creneaux[$creneau['Creneau']])) {
                        // Si Salles contient Teams on met visio à true et on enlève le mot Teams
                        if (str_contains($creneau['Salles'] ?? null, 'Teams')) {
                            $coursData['Salles'] = str_replace('Teams', '', $creneau['Salles']);
                            $creneau['visio'] = true;
                        }
                        $coursData = [];
                        $coursData['creneau'] = $creneau['Creneau'];
                        $coursData['activite'] = $creneau['Activite'] ?? null;
                        $coursData['id'] = $creneau['Id'] ?? null;
                        $coursData['couleur'] = $creneau['Couleur'] ?? null;
                        $coursData['horaire'] = $creneaux[$creneau['Creneau']];
                        $coursData['salle'] = $creneau['Salles'] ?? null;
                        $coursData['visio'] = $creneau['visio'] ?? false;
                        $jourData['cours'][] = $coursData;
                    }
                }

                $filteredData[] = $jourData;
            }
        }

        return $filteredData;
    }

    public function fetchXmlData(string $xmlUrl): string
    {
        $httpClient = HttpClient::create();
        return $httpClient->request('GET', $xmlUrl)->getContent();
    }

    public function parseXmlData(string $xmlContent): array
    {
        $xmlHash = simplexml_load_string($xmlContent);
        return json_decode(json_encode($xmlHash), true);
    }


    public function fetchAndParseData(string $xmlUrl): array
    {
        $xmlContent = $this->fetchXmlData($xmlUrl);
        $parsedData = $this->parseXmlData($xmlContent);
        return $this->filterParsedData($parsedData);
    }
}
