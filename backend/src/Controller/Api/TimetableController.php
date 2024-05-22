<?php

namespace App\Controller\Api;

use App\Service\JsonService;
use App\Service\TimetableService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Contracts\HttpClient\Exception\ClientExceptionInterface;
use Symfony\Contracts\HttpClient\Exception\RedirectionExceptionInterface;
use Symfony\Contracts\HttpClient\Exception\ServerExceptionInterface;
use Symfony\Contracts\HttpClient\Exception\TransportExceptionInterface;

class TimetableController extends AbstractController
{
    private TimetableService $timetableService;
    private JsonService $jsonService;

    public function __construct(TimetableService $timetableService, JsonService $jsonService)
    {
        $this->timetableService = $timetableService;
        $this->jsonService = $jsonService;
    }

    /**
     * Get the timetable for a given class.
     *
     * @throws TransportExceptionInterface
     * @throws ServerExceptionInterface
     * @throws RedirectionExceptionInterface
     * @throws ClientExceptionInterface
     */
    #[Route('/api/timetable', name: 'api_timetable')]
    public function index(Request $request): Response
    {
        $classParam = $request->query->get('class_param');
        if (!$classParam) {
            return $this->json(['error' => 'class_param is missing'], Response::HTTP_BAD_REQUEST);
        }

        $xmlUrl = $this->timetableService->getXmlFile($classParam);

        if ($xmlUrl) {
            $timetable = $this->timetableService->fetchAndParseData($xmlUrl)['weeks'];
            $jsonTimeTable = $this->jsonService->EntityToJson($timetable);

            return new Response($jsonTimeTable, Response::HTTP_OK, ['Content-Type' => 'application/json']);
        } else {
            return $this->json(['error' => 'Invalid XML url'], Response::HTTP_BAD_REQUEST);
        }
    }
}
