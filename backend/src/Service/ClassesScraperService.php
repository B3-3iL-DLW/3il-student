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

        $classes = [];
        $crawler->filter('#idGroupe option')->each(function ($option) use (&$classes) {
            $classes[] = [
                'file' => $option->attr('value'),
                'name' => $option->text(),
            ];
        });

        return $classes;
    }
}
