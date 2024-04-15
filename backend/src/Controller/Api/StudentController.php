<?php

namespace App\Controller\Api;

use App\Service\StudentService;
use GuzzleHttp\Exception\GuzzleException;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class StudentController extends AbstractController
{
    private StudentService $studentService;

    public function __construct(StudentService $studentService)
    {
        $this->studentService = $studentService;
    }

    /**
     * @throws GuzzleException
     */
    #[Route('/api/student/marks/{studentId}', name: 'app_api_student_rating')]
    public function getMarks(int $studentId): Response
    {
        $pdfContent = $this->studentService->marksSheet($studentId);
        if (!$pdfContent) {
            return $this->json(['message' => 'Erreur de récupération du PDF'], 500);
        } else {
            return new Response($pdfContent, 200, [
                'Content-Type' => 'application/pdf',
                'Content-Disposition' => 'inline; filename="releve.pdf"',
            ]);
        }
    }

    #[Route('/api/student/absences/{studentId}', name: 'app_api_student_absence')]
    public function getAbsence(int $studentId): Response
    {
        $pdfContent = $this->studentService->absencesSheet($studentId);
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
