<?php

namespace App\Controller\Api;

use App\Service\Scrapper\StudentSpaceScrapperService;
use App\Service\LoginService;
use GuzzleHttp\Exception\GuzzleException;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Contracts\HttpClient\Exception\ClientExceptionInterface;
use Symfony\Contracts\HttpClient\Exception\RedirectionExceptionInterface;
use Symfony\Contracts\HttpClient\Exception\ServerExceptionInterface;

class LoginController extends AbstractController
{
    private StudentSpaceScrapperService $studentScrapper;
    private LoginService $loginService;

    public function __construct(StudentSpaceScrapperService $studentScrapper, LoginService $loginService)
    {
        $this->studentScrapper = $studentScrapper;
        $this->loginService = $loginService;
    }

    /**
     * @throws ServerExceptionInterface
     * @throws RedirectionExceptionInterface
     * @throws GuzzleException
     * @throws ClientExceptionInterface
     */
    #[Route('/api/login', name: 'app_api_student_login')]
    public function login(Request $request): Response
    {
        $username = $request->get('username');
        $password = $request->get('password');

        if (null === $username || null === $password) {
            return $this->json(['message' => 'Veuillez renseigner un nom d\'utilisateur et un mot de passe'], 400);
        }

        $htmlContent = $this->studentScrapper->getLoginToken();
        $cookieJar = $this->studentScrapper->getCookies();
        $login = $this->loginService->login($username, $password, $htmlContent, $cookieJar);

        if (false === $login) {
            return $this->json(['message' => 'Erreur de connexion'], 401);
        } else {
            return $this->json(['message' => 'Connexion réussie', 'studentId' => $login], 200);
        }
    }
}