<?php

namespace App\Command;

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

    public function __construct(TimetableService $timetableService, ClassesScraperService $classesScraperService, string $schedule_url)
    {
        $this->timetableService = $timetableService;
        $this->classesScraperService = $classesScraperService;
        $this->schedule_url = $schedule_url;

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
            $currentData = $data['weeks'];
            $changes = $data['changes'];

            if ($changes) {
                $this->sendFirebaseNotification($changes);
                $output->writeln('Changes detected pour la classe '.$class->getName());
            } else {
                $output->writeln('No changes detected pour la classe '.$class->getName());
            }
        }

        return Command::SUCCESS;
    }

    private function sendFirebaseNotification($changes)
    {
        // Implement this method to send a Firebase notification
    }
}
