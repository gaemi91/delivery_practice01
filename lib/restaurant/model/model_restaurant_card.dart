import 'package:delivery_practice01/common/utils/utils_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model_restaurant_card.g.dart';

enum PriceRange { expensive, medium, cheap }

@JsonSerializable()
class ModelRestaurantCard {
  final String id;
  final String name;
  @JsonKey(fromJson: UtilsData.pathToUrl)
  final String thumbUrl;
  final List<String> tags;
  final PriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  ModelRestaurantCard({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  factory ModelRestaurantCard.fromJson(Map<String, dynamic> json) => _$ModelRestaurantCardFromJson(json);
  Map<String,dynamic> toJson()=>_$ModelRestaurantCardToJson(this);
}
