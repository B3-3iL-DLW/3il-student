<?php

namespace App\Entity;

use App\Repository\EventHoursRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: EventHoursRepository::class)]
class EventHours
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 10)]
    private ?string $startAt = null;

    #[ORM\Column(length: 10)]
    private ?string $endAt = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function setId(?int $id): void
    {
        $this->id = $id;
    }



    public function getStartAt(): ?string
    {
        return $this->startAt;
    }

    public function setStartAt(string $startAt): static
    {
        $this->startAt = $startAt;

        return $this;
    }

    public function getEndAt(): ?string
    {
        return $this->endAt;
    }

    public function setEndAt(string $endAt): static
    {
        $this->endAt = $endAt;

        return $this;
    }
}
