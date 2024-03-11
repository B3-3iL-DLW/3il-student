<?php
// ClassesController.php
namespace App\Controller\Api;

use App\Service\ClassesScraperService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Contracts\HttpClient\Exception\TransportExceptionInterface;

class ClassesController extends AbstractController
{
    private ClassesScraperService $classesScraperService;

    public function __construct(ClassesScraperService $classesScraperService)
    {
        $this->classesScraperService = $classesScraperService;
    }

    /**
     * @throws TransportExceptionInterface
     */
    #[Route('/api/classes', name: 'api_classes')]
    public function getClasses(): JsonResponse
    {
        $classes = $this->classesScraperService->scrapeClasses();
        return $this->json($classes);
    }
}
