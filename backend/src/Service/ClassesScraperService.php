<?php

namespace App\Service;

use Symfony\Component\HttpClient\HttpClient;
use Symfony\Component\DomCrawler\Crawler;

class ClassesScraperService
{
    private string $schedule_url;

    public function __construct(string $schedule_url)
    {
        $this->schedule_url = $schedule_url;
    }
    public function scrapeClasses(): array
    {
        $httpClient = HttpClient::create();
        $htmlContent = $httpClient->request('GET', $this->schedule_url)->getContent();
        $crawler = new Crawler($htmlContent);

        $classes = $crawler->filter('select[name="classe"] option')->each(function (Crawler $node, $i) {
            return $node->text();
        });

        return $classes;
    }
}
