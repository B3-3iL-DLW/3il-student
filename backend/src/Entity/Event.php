<?php

namespace App\Entity;

use App\Repository\EventRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: EventRepository::class)]
class Event
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column]
    private ?int $creneau = null;

    #[ORM\Column(length: 255)]
    private ?string $activite = null;

    #[ORM\Column(length: 255)]
    private ?string $couleur = null;

    #[ORM\OneToOne(cascade: ['persist', 'remove'])]
    #[ORM\JoinColumn(nullable: false)]
    private ?EventHours $horaire = null;

    #[ORM\Column(length: 255)]
    private ?string $salle = null;

    #[ORM\Column]
    private ?bool $visio = null;

    #[ORM\ManyToOne(inversedBy: 'events')]
    #[ORM\JoinColumn(nullable: false)]
    private ?DaySchedule $daySchedule = null;

    #[ORM\Column]
    private ?bool $repas = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getCreneau(): ?int
    {
        return $this->creneau;
    }

    public function setCreneau(int $creneau): static
    {
        $this->creneau = $creneau;

        return $this;
    }

    public function getActivite(): ?string
    {
        return $this->activite;
    }

    public function setActivite(string $activite): static
    {
        $this->activite = $activite;

        return $this;
    }

    public function setId(int $id): static
    {
        $this->id = $id;

        return $this;
    }

    public function getCouleur(): ?string
    {
        return $this->couleur;
    }

    public function setCouleur(string $couleur): static
    {
        $this->couleur = $couleur;

        return $this;
    }

    public function getHoraire(): ?EventHours
    {
        return $this->horaire;
    }

    public function setHoraire(EventHours $horaire): static
    {
        $this->horaire = $horaire;

        return $this;
    }

    public function getSalle(): ?string
    {
        return $this->salle;
    }

    public function setSalle(string $salle): static
    {
        $this->salle = $salle;

        return $this;
    }

    public function isVisio(): ?bool
    {
        return $this->visio;
    }

    public function setVisio(bool $visio): static
    {
        $this->visio = $visio;

        return $this;
    }

    public function getDaySchedule(): ?DaySchedule
    {
        return $this->daySchedule;
    }

    public function setDaySchedule(?DaySchedule $daySchedule): static
    {
        $this->daySchedule = $daySchedule;

        return $this;
    }

    public function isRepas(): ?bool
    {
        return $this->repas;
    }

    public function setRepas(bool $repas): static
    {
        $this->repas = $repas;

        return $this;
    }
}
