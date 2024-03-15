<?php

namespace App\Repository;

use App\Entity\DaySchedule;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<DaySchedule>
 *
 * @method DaySchedule|null find($id, $lockMode = null, $lockVersion = null)
 * @method DaySchedule|null findOneBy(array $criteria, array $orderBy = null)
 * @method DaySchedule[]    findAll()
 * @method DaySchedule[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class DayScheduleRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, DaySchedule::class);
    }

    //    /**
    //     * @return DaySchedule[] Returns an array of DaySchedule objects
    //     */
    //    public function findByExampleField($value): array
    //    {
    //        return $this->createQueryBuilder('d')
    //            ->andWhere('d.exampleField = :val')
    //            ->setParameter('val', $value)
    //            ->orderBy('d.id', 'ASC')
    //            ->setMaxResults(10)
    //            ->getQuery()
    //            ->getResult()
    //        ;
    //    }

    //    public function findOneBySomeField($value): ?DaySchedule
    //    {
    //        return $this->createQueryBuilder('d')
    //            ->andWhere('d.exampleField = :val')
    //            ->setParameter('val', $value)
    //            ->getQuery()
    //            ->getOneOrNullResult()
    //        ;
    //    }
}
