<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20240521125320 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE class_groups (id INT AUTO_INCREMENT NOT NULL, file VARCHAR(255) NOT NULL, name VARCHAR(255) NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE day_schedule (id INT AUTO_INCREMENT NOT NULL, week_schedule_id INT NOT NULL, date DATETIME NOT NULL, jour INT NOT NULL, INDEX IDX_59763687DFBAC9AC (week_schedule_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE event (id INT AUTO_INCREMENT NOT NULL, horaire_id INT NOT NULL, day_schedule_id INT NOT NULL, creneau INT NOT NULL, activite VARCHAR(255) NOT NULL, couleur VARCHAR(255) NOT NULL, salle VARCHAR(255) NOT NULL, visio TINYINT(1) NOT NULL, repas TINYINT(1) NOT NULL, eval TINYINT(1) NOT NULL, UNIQUE INDEX UNIQ_3BAE0AA758C54515 (horaire_id), INDEX IDX_3BAE0AA7B2418D10 (day_schedule_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE event_hours (id INT AUTO_INCREMENT NOT NULL, start_at VARCHAR(10) NOT NULL, end_at VARCHAR(10) NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE week_schedule (id INT AUTO_INCREMENT NOT NULL, code VARCHAR(255) NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('ALTER TABLE day_schedule ADD CONSTRAINT FK_59763687DFBAC9AC FOREIGN KEY (week_schedule_id) REFERENCES week_schedule (id)');
        $this->addSql('ALTER TABLE event ADD CONSTRAINT FK_3BAE0AA758C54515 FOREIGN KEY (horaire_id) REFERENCES event_hours (id)');
        $this->addSql('ALTER TABLE event ADD CONSTRAINT FK_3BAE0AA7B2418D10 FOREIGN KEY (day_schedule_id) REFERENCES day_schedule (id)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE day_schedule DROP FOREIGN KEY FK_59763687DFBAC9AC');
        $this->addSql('ALTER TABLE event DROP FOREIGN KEY FK_3BAE0AA758C54515');
        $this->addSql('ALTER TABLE event DROP FOREIGN KEY FK_3BAE0AA7B2418D10');
        $this->addSql('DROP TABLE class_groups');
        $this->addSql('DROP TABLE day_schedule');
        $this->addSql('DROP TABLE event');
        $this->addSql('DROP TABLE event_hours');
        $this->addSql('DROP TABLE week_schedule');
    }
}
