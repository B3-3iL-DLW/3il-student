<?php

namespace App\Entity;

use App\Repository\DayScheduleRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: DayScheduleRepository::class)]
class DaySchedule
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id;

    #[ORM\Column(type: Types::DATETIME_MUTABLE)]
    private ?\DateTimeInterface $date = null;

    #[ORM\Column]
    private ?int $jour = null;

    #[ORM\OneToMany(targetEntity: Event::class, mappedBy: 'daySchedule')]
    private Collection $events;

    #[ORM\ManyToOne(inversedBy: 'DaySchedule', cascade: ["persist"])]
    #[ORM\JoinColumn(nullable: false)]
    private ?WeekSchedule $weekSchedule = null;

    public function __construct()
    {
        $this->events = new ArrayCollection();
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

    public function getDate(): ?\DateTimeInterface
    {
        return $this->date;
    }

    public function setDate(\DateTimeInterface $date): static
    {
        $this->date = $date;

        return $this;
    }

    public function getJour(): ?int
    {
        return $this->jour;
    }

    public function setJour(int $jour): static
    {
        $this->jour = $jour;

        return $this;
    }

    /**
     * @return Collection<int, Event>
     */
    public function getEvents(): Collection
    {
        return $this->events;
    }

    public function addEvent(Event $event): static
    {
        if (!$this->events->contains($event)) {
            $this->events->add($event);
            $event->setDaySchedule($this);
        }

        return $this;
    }

    public function removeEvent(Event $event): static
    {
        if ($this->events->removeElement($event)) {
            // set the owning side to null (unless already changed)
            if ($event->getDaySchedule() === $this) {
                $event->setDaySchedule(null);
            }
        }

        return $this;
    }

    public function getWeekSchedule(): ?WeekSchedule
    {
        return $this->weekSchedule;
    }

    public function setWeekSchedule(?WeekSchedule $weekSchedule): static
    {
        $this->weekSchedule = $weekSchedule;

        return $this;
    }
}
