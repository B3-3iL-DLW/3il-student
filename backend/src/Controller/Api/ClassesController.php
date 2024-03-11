<?php
// ClassesController.php
namespace App\Controller\Api;

use App\Service\ClassesScraperService;
use App\Service\JsonService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Contracts\HttpClient\Exception\TransportExceptionInterface;

class ClassesController extends AbstractController
{
    private ClassesScraperService $classesScraperService;
    private JsonService $jsonService;

    public function __construct(ClassesScraperService $classesScraperService, JsonService $jsonService)
    {
        $this->classesScraperService = $classesScraperService;
        $this->jsonService = $jsonService;
    }


    /**
     * @throws TransportExceptionInterface
     */
    #[Route('/api/classes', name: 'api_classes')]
    public function getClasses(): Response
    {
        $classes = $this->classesScraperService->scrapeClasses();
        $jsonClasses = $this->jsonService->EntityToJson($classes);
        return new Response($jsonClasses, Response::HTTP_OK, ['Content-Type' => 'application/json']);
    }
}
