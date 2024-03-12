<?php

namespace App\Repository;

use App\Entity\EventHours;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<EventHours>
 *
 * @method EventHours|null find($id, $lockMode = null, $lockVersion = null)
 * @method EventHours|null findOneBy(array $criteria, array $orderBy = null)
 * @method EventHours[]    findAll()
 * @method EventHours[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class EventHoursRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, EventHours::class);
    }

    //    /**
    //     * @return EventHours[] Returns an array of EventHours objects
    //     */
    //    public function findByExampleField($value): array
    //    {
    //        return $this->createQueryBuilder('c')
    //            ->andWhere('c.exampleField = :val')
    //            ->setParameter('val', $value)
    //            ->orderBy('c.id', 'ASC')
    //            ->setMaxResults(10)
    //            ->getQuery()
    //            ->getResult()
    //        ;
    //    }

    //    public function findOneBySomeField($value): ?EventHours
    //    {
    //        return $this->createQueryBuilder('c')
    //            ->andWhere('c.exampleField = :val')
    //            ->setParameter('val', $value)
    //            ->getQuery()
    //            ->getOneOrNullResult()
    //        ;
    //    }
}
