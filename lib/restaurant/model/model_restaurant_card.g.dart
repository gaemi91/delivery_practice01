// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_restaurant_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelRestaurantCard _$ModelRestaurantCardFromJson(Map<String, dynamic> json) =>
    ModelRestaurantCard(
      id: json['id'] as String,
      name: json['name'] as String,
      thumbUrl: UtilsData.pathToUrl(json['thumbUrl'] as String),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      priceRange: $enumDecode(_$PriceRangeEnumMap, json['priceRange']),
      ratings: (json['ratings'] as num).toDouble(),
      ratingsCount: json['ratingsCount'] as int,
      deliveryTime: json['deliveryTime'] as int,
      deliveryFee: json['deliveryFee'] as int,
    );

Map<String, dynamic> _$ModelRestaurantCardToJson(
        ModelRestaurantCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbUrl': instance.thumbUrl,
      'tags': instance.tags,
      'priceRange': _$PriceRangeEnumMap[instance.priceRange]!,
      'ratings': instance.ratings,
      'ratingsCount': instance.ratingsCount,
      'deliveryTime': instance.deliveryTime,
      'deliveryFee': instance.deliveryFee,
    };

const _$PriceRangeEnumMap = {
  PriceRange.expensive: 'expensive',
  PriceRange.medium: 'medium',
  PriceRange.cheap: 'cheap',
};
