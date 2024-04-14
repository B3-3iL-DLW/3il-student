<?php

namespace App\Service;

use GuzzleHttp\Client;
use GuzzleHttp\Cookie\CookieJar;

class StudentLoginService
{
    public function login(string $username, string $password, string $token, CookieJar $cookieJar): int|bool|null
    {
        $client = new Client(['cookies' => $cookieJar, 'allow_redirects' => true]);
        $response = $client->request('POST', 'https://eleves.groupe3il.fr/index.php/component/users/?task=user.login&Itemid=435', [
            'headers' => [
                'Content-Type' => 'application/x-www-form-urlencoded',
            ],
            'form_params' => [
                'username' => $username,
                'password' => $password,
                'remember' => 'yes',
                'return' => 'aW5kZXgucGhwP0l0ZW1pZD00ODA=',
                $token => '1',
            ],
        ]);

        $htmlContent = $response->getBody()->getContents();

        if (str_contains($htmlContent, 'Voici la liste des relevés disponibles')) {
            $pattern = '/\[NoteEleveId\] => (\d+)/';
            preg_match($pattern, $htmlContent, $matches);
            return $matches[1] ?? false;
        }

        return false;
    }
}
