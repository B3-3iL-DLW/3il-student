<?php

namespace App\Service;

use GuzzleHttp\Client;
use GuzzleHttp\Exception\GuzzleException;

class StudentService
{

    private string $marksSheetUrl;
    private string $absencesSheetUrl;

    public function __construct(string $marksSheetUrl, string $absencesSheetUrl)
    {
        $this->marksSheetUrl = $marksSheetUrl;
        $this->absencesSheetUrl = $absencesSheetUrl;
    }

    /**
     * @throws GuzzleException
     */
    public function marksSheet(int $studentId): string
    {
        $client = new Client();
        $url = str_replace('{studentId}', $studentId, $this->marksSheetUrl);
        $response = $client->request('GET', $url);

        return $response->getBody()->getContents();
    }

    /**
     * @throws GuzzleException
     */
    public function absencesSheet(int $studentId): string
    {
        $client = new Client();
        $url = str_replace('{studentId}', $studentId, $this->absencesSheetUrl);
        $response = $client->request('GET', $url);

        return $response->getBody()->getContents();
    }
}