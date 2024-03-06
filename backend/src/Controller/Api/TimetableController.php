<?php

namespace App\Controller\Api;

use App\Service\TimetableService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

class TimetableController extends AbstractController
{
    private $timetableService;

    public function __construct(TimetableService $timetableService)
    {
        $this->timetableService = $timetableService;
    }

    #[Route('/api/timetable', name: 'api_timetable')]
    public function index(Request $request): JsonResponse
    {
        $classParam = $request->query->get('class_param');
        $xmlUrl = $this->timetableService->getXmlFile($classParam);

        dd($xmlUrl);
        dd($classParam);

        if ($xmlUrl) {
            $parsedJson = $this->timetableService->fetchAndParseData($xmlUrl);

            return $this->json($parsedJson);
        } else {
            return $this->json(['error' => 'Invalid class_param'], JsonResponse::HTTP_BAD_REQUEST);
        }
    }
}
