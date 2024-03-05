<?php

namespace App\Service;

use Symfony\Component\HttpClient\HttpClient;
use Symfony\Component\DomCrawler\Crawler;

class ClassesScraperService
{
    public function scrapeClasses(string $url): array
    {
        $httpClient = HttpClient::create();
        $htmlContent = $httpClient->request('GET', $url)->getContent();
        $crawler = new Crawler($htmlContent);

        $classes = $crawler->filter('select[name="classe"] option')->each(function (Crawler $node, $i) {
            return $node->text();
        });

        return $classes;
    }
}
