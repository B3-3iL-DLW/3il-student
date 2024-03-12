<?php

namespace App\Service;

use App\Entity\ClassGroups;
use Symfony\Component\DomCrawler\Crawler;
use Symfony\Component\HttpClient\HttpClient;
use Symfony\Contracts\HttpClient\Exception\TransportExceptionInterface;

class ClassesScraperService
{
    private string $schedule_url;

    public function __construct(string $schedule_url)
    {
        $this->schedule_url = $schedule_url;
    }

    /**
     * Scrape the classes from the schedule website.
     *
     * @throws TransportExceptionInterface
     */
    public function scrapeClasses(): array
    {
        $httpClient = HttpClient::create();
        $htmlContent = $httpClient->request('GET', $this->schedule_url.'00_index.php')->getContent();
        $crawler = new Crawler($htmlContent);

        $classes = [];
        $crawler->filter('#idGroupe option')->each(function ($option) use (&$classes) {
            $classGroup = new ClassGroups();
            $classGroup->setName($option->text());
            $classGroup->setFile($option->attr('value'));
            $classes[] = $classGroup;
        });

        return $classes;
    }
}
