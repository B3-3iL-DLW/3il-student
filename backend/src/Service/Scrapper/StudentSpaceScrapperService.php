<?php

namespace App\Service\Scrapper;

use GuzzleHttp\Client;
use GuzzleHttp\Cookie\CookieJar;
use GuzzleHttp\Exception\GuzzleException;
use Symfony\Contracts\HttpClient\Exception\ClientExceptionInterface;
use Symfony\Contracts\HttpClient\Exception\RedirectionExceptionInterface;
use Symfony\Contracts\HttpClient\Exception\ServerExceptionInterface;
use Symfony\Contracts\HttpClient\Exception\TransportExceptionInterface;

class StudentSpaceScrapperService
{
    private string $url;
    private CookieJar $cookieJar;

    public function __construct(string $url)
    {
        $this->url = $url;
    }

    /**
     * @throws ServerExceptionInterface
     * @throws RedirectionExceptionInterface
     * @throws ClientExceptionInterface|GuzzleException
     */
    private function getHtmlContent(): string
    {
        $this->cookieJar = new CookieJar();
        $client = new Client(['cookies' => $this->cookieJar, 'allow_redirects' => true]);
        $response = $client->request('GET', $this->url);

        return $response->getBody()->getContents();
    }

    private function parseLoginToken(string $htmlContent): string
    {
        $dom = new \DOMDocument();
        @$dom->loadHTML($htmlContent);
        $xpath = new \DOMXPath($dom);
        $returnElements = $xpath->query("//input[@name='return']");
        if ($returnElements->length > 0) {
            // Récupérer le prochain élément input
            $nextInput = $xpath->query('following-sibling::input[1]', $returnElements->item(0));
            if ($nextInput->length > 0) {
                // Récupérer le nom de l'élément
                return $nextInput->item(0)->getAttribute('name');
            }
        }

        return '';
    }

    /**
     * @throws ServerExceptionInterface
     * @throws RedirectionExceptionInterface
     * @throws GuzzleException
     * @throws ClientExceptionInterface
     */
    public function getLoginToken(): string
    {
        $htmlContent = $this->getHtmlContent();

        return $this->parseLoginToken($htmlContent);
    }


    public function getCookies(): CookieJar
    {
        return $this->cookieJar;
    }

}
