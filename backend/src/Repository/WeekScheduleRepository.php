<?php

namespace App\Repository;

use App\Entity\WeekSchedule;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<WeekSchedule>
 *
 * @method WeekSchedule|null find($id, $lockMode = null, $lockVersion = null)
 * @method WeekSchedule|null findOneBy(array $criteria, array $orderBy = null)
 * @method WeekSchedule[]    findAll()
 * @method WeekSchedule[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class WeekScheduleRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, WeekSchedule::class);
    }

    //    /**
    //     * @return WeekSchedule[] Returns an array of WeekSchedule objects
    //     */
    //    public function findByExampleField($value): array
    //    {
    //        return $this->createQueryBuilder('w')
    //            ->andWhere('w.exampleField = :val')
    //            ->setParameter('val', $value)
    //            ->orderBy('w.id', 'ASC')
    //            ->setMaxResults(10)
    //            ->getQuery()
    //            ->getResult()
    //        ;
    //    }

    //    public function findOneBySomeField($value): ?WeekSchedule
    //    {
    //        return $this->createQueryBuilder('w')
    //            ->andWhere('w.exampleField = :val')
    //            ->setParameter('val', $value)
    //            ->getQuery()
    //            ->getOneOrNullResult()
    //        ;
    //    }
}
