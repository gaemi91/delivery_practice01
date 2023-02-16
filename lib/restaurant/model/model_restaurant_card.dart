import 'package:delivery_practice01/common/const/data.dart';

enum PriceRange {
  expensive,
  medium,
  cheap,
}

class ModelRestaurantCard {
  final String id;
  final String name;
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

  factory ModelRestaurantCard.fromJson({required Map<String, dynamic> json}) {
    return ModelRestaurantCard(
      id: json['id'],
      name: json['name'],
      thumbUrl: 'http://$ip${json['thumbUrl']}',
      tags: List.from(json['tags']),
      priceRange: PriceRange.values.firstWhere((e) => e.name == json['priceRange']),
      ratings: json['ratings'],
      ratingsCount: json['ratingsCount'],
      deliveryTime: json['deliveryTime'],
      deliveryFee: json['deliveryFee'],
    );
  }
}
