<?php

namespace App\Repository;

use App\Entity\ClassGroups;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<ClassGroups>
 *
 * @method ClassGroups|null find($id, $lockMode = null, $lockVersion = null)
 * @method ClassGroups|null findOneBy(array $criteria, array $orderBy = null)
 * @method ClassGroups[]    findAll()
 * @method ClassGroups[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ClassGroupsRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, ClassGroups::class);
    }

    //    /**
    //     * @return ClassGroups[] Returns an array of ClassGroups objects
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

    //    public function findOneBySomeField($value): ?ClassGroups
    //    {
    //        return $this->createQueryBuilder('c')
    //            ->andWhere('c.exampleField = :val')
    //            ->setParameter('val', $value)
    //            ->getQuery()
    //            ->getOneOrNullResult()
    //        ;
    //    }
}
