<?php

namespace App\Entity;

use App\Repository\TimetableRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Ramsey\Uuid\Uuid;
use Ramsey\Uuid\UuidInterface;

#[ORM\Entity(repositoryClass: TimetableRepository::class)]
class Timetable
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id;

    #[ORM\OneToMany(targetEntity: WeekSchedule::class, mappedBy: 'timetable')]
    private Collection $Weeks;

    public function __construct()
    {
        $this->Weeks = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function setId(int $id): static
    {
        $this->id = $id;

        return $this;
    }

    /**
     * @return Collection<int, WeekSchedule>
     */
    public function getWeeks(): Collection
    {
        return $this->Weeks;
    }

    public function addWeek(WeekSchedule $week): static
    {
        if (!$this->Weeks->contains($week)) {
            $this->Weeks->add($week);
            $week->setTimetable($this);
        }

        return $this;
    }

    public function removeWeek(WeekSchedule $week): static
    {
        if ($this->Weeks->removeElement($week)) {
            // set the owning side to null (unless already changed)
            if ($week->getTimetable() === $this) {
                $week->setTimetable(null);
            }
        }

        return $this;
    }
}
