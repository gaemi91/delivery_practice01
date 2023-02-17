import 'package:delivery_practice01/common/const/data.dart';
import 'package:delivery_practice01/common/utils/utils_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model_restaurant.g.dart';

enum PriceRange {
  expensive,
  medium,
  cheap,
}

@JsonSerializable()
class ModelRestaurant {
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

  ModelRestaurant({
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

  factory ModelRestaurant.fromJson(Map<String, dynamic> json) => _$ModelRestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$ModelRestaurantToJson(this);
}
