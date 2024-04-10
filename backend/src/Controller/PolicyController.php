<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Attribute\Route;

class PolicyController extends AbstractController
{
    #[Route('/policy', name: 'app_policy')]
    public function index(): \Symfony\Component\HttpFoundation\Response
    {
        return $this->render('policy/index.html.twig');
    }
}
