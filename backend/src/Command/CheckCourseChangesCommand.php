<?php

namespace App\Command;

use App\Service\FirebaseService;
use App\Service\Scrapper\ClassesScraperService;
use App\Service\TimetableService;
use Symfony\Component\Console\Attribute\AsCommand;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

#[AsCommand(name: 'app:check-course-changes')]
class CheckCourseChangesCommand extends Command
{
    private TimetableService $timetableService;
    private ClassesScraperService $classesScraperService;
    private string $schedule_url;
    private FirebaseService $firebaseService;

    public function __construct(TimetableService $timetableService, ClassesScraperService $classesScraperService, string $schedule_url, FirebaseService $firebaseService)
    {
        $this->timetableService = $timetableService;
        $this->classesScraperService = $classesScraperService;
        $this->schedule_url = $schedule_url;
        $this->firebaseService = $firebaseService;

        parent::__construct();
    }

    protected function configure(): void
    {
        $this->setDescription('Check for course changes and send Firebase notifications.');
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $classes = $this->classesScraperService->scrapeClasses();

        foreach ($classes as $class) {
            $encodedClassFile = str_replace(' ', '%20', $class->getFile());

            $data = $this->timetableService->fetchAndParseData($this->schedule_url.$encodedClassFile);
            $changes = $data['changes'];

            if ($changes) {
                $this->sendFirebaseNotification($changes, $class, $output);
                $output->writeln('Changes detected pour la classe '.$class->getName());
            } else {
                $output->writeln('No changes detected pour la classe '.$class->getName());
            }
            // On attends 1 seconde pour éviter de spammer le serveur
            sleep(1);
        }

        return Command::SUCCESS;
    }

    private function sendFirebaseNotification($changes, $class, $outpout): void
    {
        $class = str_replace(' ', '', $class->getName());
        $outpout->writeln('Sending notification to '.$class);
        $this->firebaseService->sendNotification('Changement d\'emploi du temps', 'Il y a eu des changements dans votre emploi du temps', $class);
    }
}
