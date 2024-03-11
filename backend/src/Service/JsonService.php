<?php

namespace App\Service;

use Symfony\Component\Serializer\Encoder\JsonEncoder;
use Symfony\Component\Serializer\Normalizer\AbstractNormalizer;
use Symfony\Component\Serializer\Normalizer\DateTimeNormalizer;
use Symfony\Component\Serializer\Normalizer\ObjectNormalizer;
use Symfony\Component\Serializer\Serializer;

class JsonService
{

    /**
     * Convert an entity to a JSON string
     *
     * @param $entity
     * @return string
     */
    public function EntityToJson($entity): string
    {
        $encoder = new JsonEncoder();
        $defaultContext = [
            AbstractNormalizer::CIRCULAR_REFERENCE_HANDLER => function (object $object, string $format, array $context): string {
                return $object->getId();
            },
            DateTimeNormalizer::FORMAT_KEY => [
                'datetime' => 'Y-m-d',
                'datetime_immutable' => 'Y-m-d',
            ],
        ];

        $normalizer = array(new DateTimeNormalizer(), new ObjectNormalizer(null, null, null, null, null, null, $defaultContext));

        $serializer = new Serializer($normalizer, [$encoder]);
        return $serializer->serialize($entity, 'json');
    }

}