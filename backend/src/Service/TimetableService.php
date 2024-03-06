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

        // Parcourir chaque semaine
        foreach ($parsedData['GROUPE']['PLAGES']['SEMAINE'] as $semaine) {
            // Parcourir chaque jour de la semaine
            foreach ($semaine['JOUR'] as $jour) {
                $jourDeLaSemaine = date('N', strtotime($jour['Date']));

                // ignore week-end
                if ($jourDeLaSemaine > 5) {
                    continue;
                }

                // Initialiser un tableau pour stocker les informations d'un jour
                $jourData = [];
                $jourData['date'] = $jour['Date'];
                $jourData['jour'] = $jour['Jour'];

                // Indicateur pour vérifier si tous les créneaux sont nuls
                $allCreneauxNull = true;

                // Parcourir chaque créneau du jour
                foreach ($jour['CRENEAU'] as $creneau) {
                    // Vérifier si le numéro de créneau existe dans votre liste de créneaux définis
                    if (isset($creneaux[$creneau['Creneau']])) {

                        if (isset($creneau['Id'])) {
                            // Marquer l'indicateur à false si au moins un créneau n'est pas nul
                            if ($creneau['Id'] !== null) {
                                $allCreneauxNull = false;
                            }
                        }
                    }
                }

                // Si tous les créneaux sont nuls, passer à l'itération suivante
                if ($allCreneauxNull) {
                    continue;
                }

                // Parcourir à nouveau chaque créneau pour construire les données filtrées
                foreach ($jour['CRENEAU'] as $creneau) {
                    // Vérifier si le numéro de créneau existe dans votre liste de créneaux définis
                    if (isset($creneaux[$creneau['Creneau']])) {
                        // Créer un tableau pour stocker les informations d'un cours
                        $coursData = [];
                        $coursData['creneau'] = $creneau['Creneau'];
                        $coursData['activite'] = $creneau['Activite'] ?? null;
                        $coursData['id'] = $creneau['Id'] ?? null;
                        $coursData['couleur'] = $creneau['Couleur'] ?? null;
                        $coursData['horaire'] = $creneaux[$creneau['Creneau']];
                        $coursData['salle'] = $creneau['Salles'] ?? null;

                        // Ajouter les informations du cours au tableau du jour
                        $jourData['cours'][] = $coursData;
                    }
                }

                // Ajouter les informations du jour au tableau filtré
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
