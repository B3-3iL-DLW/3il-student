<?php

namespace App\Controller\Api;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpClient\HttpClient;
use Symfony\Component\DomCrawler\Crawler;

class EmploiDuTempsController extends AbstractController
{
    #[Route('/api/edt', name: 'api_edt')]
    public function index(Request $request): JsonResponse
    {
        $classParam = $request->query->get('class_param');
        $xmlUrl = $this->determineXmlUrl($classParam);

        if ($xmlUrl) {
            $parsedJson = $this->fetchAndParseData($xmlUrl);


            return $this->json($parsedJson);
        } else {
            return $this->json(['error' => 'Invalid class_param'], JsonResponse::HTTP_BAD_REQUEST);
        }
    }

    private function defineCreneaux(): array
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

    private function fetchAndParseData(string $xmlUrl): array
    {
        $creneaux = $this->defineCreneaux();

        $httpClient = HttpClient::create();
        $xmlContent = $httpClient->request('GET', $xmlUrl)->getContent();
        $xmlHash = simplexml_load_string($xmlContent);

        $parsedData = json_decode(json_encode($xmlHash), true);

        $filteredData = [];

        // Parcourir chaque semaine
        foreach ($parsedData['GROUPE']['PLAGES']['SEMAINE'] as $semaine) {
            // Parcourir chaque jour de la semaine
            foreach ($semaine['JOUR'] as $jour) {
                // Initialiser un tableau pour stocker les informations d'un jour
                $jourData = [];
                $jourData['date'] = $jour['Date'];
                $jourData['jour'] = $jour['Jour'];

                // Parcourir chaque créneau du jour
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



    private function scrapeClasses(string $pageUrl): array
    {
        $httpClient = HttpClient::create();
        $htmlContent = $httpClient->request('GET', $pageUrl)->getContent();
        $crawler = new Crawler($htmlContent);

        $classes = [];
        $crawler->filter('#idGroupe option')->each(function ($option) use (&$classes) {
            $classes[] = [
                'file' => $option->attr('value'),
                'name' => $option->text(),
            ];
        });

        return $classes;
    }

    private function determineXmlUrl(string $classParam): ?string
    {


        $classesList = $this->scrapeClasses('https://eleves.groupe3il.fr/edt_eleves/00_index.php');

        foreach ($classesList as $class) {
            if ($class['name'] === $classParam) {
                $encodedClassFile = str_replace(' ', '%20', $class['file']);
                return "https://eleves.groupe3il.fr/edt_eleves/{$encodedClassFile}";
            }
        }

        return null;
    }
}
