<?php

namespace App\Controller\Api;

use App\Service\JsonService;
use App\Service\TimetableService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Serializer\Encoder\JsonEncoder;
use Symfony\Component\Serializer\Normalizer\AbstractNormalizer;
use Symfony\Component\Serializer\Normalizer\ArrayDenormalizer;
use Symfony\Component\Serializer\Normalizer\DateTimeNormalizer;
use Symfony\Component\Serializer\Normalizer\GetSetMethodNormalizer;
use Symfony\Component\Serializer\Normalizer\ObjectNormalizer;
use Symfony\Component\Serializer\Serializer;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

class TimetableController extends AbstractController
{
    private TimetableService $timetableService;
    private JsonService $jsonService;

    public function __construct(TimetableService $timetableService, JsonService $jsonService)
    {
        $this->timetableService = $timetableService;
        $this->jsonService = $jsonService;
    }


    #[Route('/api/timetable', name: 'api_timetable')]
    public function index(Request $request): Response
    {
        $classParam = $request->query->get('class_param');
        if (!$classParam) {
            return $this->json(['error' => 'class_param is missing'], Response::HTTP_BAD_REQUEST);
        }
        
        $xmlUrl = $this->timetableService->getXmlFile($classParam);

        if ($xmlUrl) {
            $timetable = $this->timetableService->fetchAndParseData($xmlUrl);
            $jsonTimeTable = $this->jsonService->EntityToJson($timetable);
            return new Response($jsonTimeTable, Response::HTTP_OK, ['Content-Type' => 'application/json']);
        } else {
            return $this->json(['error' => 'Invalid XML url'], Response::HTTP_BAD_REQUEST);
        }
    }
}
