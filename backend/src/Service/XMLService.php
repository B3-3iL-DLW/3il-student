<?php

namespace App\Service;

use Symfony\Component\HttpClient\HttpClient;
use Symfony\Contracts\HttpClient\Exception\ClientExceptionInterface;
use Symfony\Contracts\HttpClient\Exception\RedirectionExceptionInterface;
use Symfony\Contracts\HttpClient\Exception\ServerExceptionInterface;
use Symfony\Contracts\HttpClient\Exception\TransportExceptionInterface;

class XMLService
{
    /**
     * Fetch XML data from a given URL
     *
     * @param string $xmlUrl The URL of the XML file
     * @throws TransportExceptionInterface
     * @throws ServerExceptionInterface
     * @throws RedirectionExceptionInterface
     * @throws ClientExceptionInterface
     */
    public function fetchXmlData(string $xmlUrl): string
    {
        $httpClient = HttpClient::create();
        return $httpClient->request('GET', $xmlUrl)->getContent();
    }

/**
     * Parse XML data into an array
     *
     * @param string $xmlContent The content of the XML file
     * @return array
     */
    public function parseXmlData(string $xmlContent): array
    {
        $xmlHash = simplexml_load_string($xmlContent);
        return json_decode(json_encode($xmlHash), true);
    }
}