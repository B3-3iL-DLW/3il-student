<?php
// ClassesController.php
namespace App\Controller\Api;

use App\Service\ClassesScraperService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;

class ClassesController extends AbstractController
{
    private $classesScraperService;

    public function __construct(ClassesScraperService $classesScraperService)
    {
        $this->classesScraperService = $classesScraperService;
    }

    #[Route('/api/classes', name: 'api_classes')]
    public function getClasses(): JsonResponse
    {
        $classes = $this->classesScraperService->scrapeClasses();
        return $this->json($classes);
    }
}
