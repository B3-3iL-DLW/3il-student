<?php

namespace App\Entity;

use App\Repository\WeekScheduleRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: WeekScheduleRepository::class)]
class WeekSchedule
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $code = null;

    #[ORM\OneToMany(targetEntity: DaySchedule::class, mappedBy: 'weekSchedule', cascade: ['persist', 'remove'])]
    private Collection $DaySchedule;

    public function __construct()
    {
        $this->DaySchedule = new ArrayCollection();
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

    public function getCode(): ?string
    {
        return $this->code;
    }

    public function setCode(string $code): static
    {
        $this->code = $code;

        return $this;
    }

    /**
     * @return Collection<int, DaySchedule>
     */
    public function getDaySchedule(): Collection
    {
        return $this->DaySchedule;
    }

    public function addDaySchedule(DaySchedule $daySchedule): static
    {
        if (!$this->DaySchedule->contains($daySchedule)) {
            $this->DaySchedule->add($daySchedule);
            $daySchedule->setWeekSchedule($this);
        }

        return $this;
    }

    public function removeDaySchedule(DaySchedule $daySchedule): static
    {
        if ($this->DaySchedule->removeElement($daySchedule)) {
            // set the owning side to null (unless already changed)
            if ($daySchedule->getWeekSchedule() === $this) {
                $daySchedule->setWeekSchedule(null);
            }
        }

        return $this;
    }
}
