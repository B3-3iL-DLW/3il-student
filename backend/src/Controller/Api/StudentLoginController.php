<?php

namespace App\Controller\Api;

use App\Service\Scrapper\StudentSpaceScrapperService;
use App\Service\StudentLoginService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class StudentLoginController extends AbstractController
{
    #[Route('/api/student/login', name: 'app_api_student_login')]
    public function index(Request $request): Response
    {
        $username = $request->get('username');
        $password = $request->get('password');
        if (null === $username || null === $password) {
            return $this->json(['message' => 'Veuillez renseigner un nom d\'utilisateur et un mot de passe'], 400);
        }
        $studentScrapper = new StudentSpaceScrapperService('https://eleves.groupe3il.fr/index.php');
        $htmlContent = $studentScrapper->getLoginToken();
        $cookieJar = $studentScrapper->getCookies();
        $studentLoginService = new StudentLoginService();
        $login = $studentLoginService->login($username, $password, $htmlContent, $cookieJar);
        if (false === $login) {
            return $this->json(['message' => 'Erreur de connexion'], 401);
        } else {
            return $this->json(['message' => 'Connexion réussie', 'studentId' => $login], 200);
        }
    }

    #[Route('/api/student/marks/{studentId}', name: 'app_api_student_marks')]
    public function marksPdf(int $studentId): Response
    {
        $studentScrapper = new StudentSpaceScrapperService('https://eleves.groupe3il.fr/index.php');
        $pdfContent = $studentScrapper->getMarksPDF($studentId);
        if (!$pdfContent) {
            return $this->json(['message' => 'Erreur de récupération du PDF'], 500);
        } else {
            return new Response($pdfContent, 200, [
                'Content-Type' => 'application/pdf',
                'Content-Disposition' => 'inline; filename="releve.pdf"',
            ]);
        }
    }
}
