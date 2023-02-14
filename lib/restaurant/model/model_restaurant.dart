enum PriceRange {
  expensive,
  medium,
  cheap,
}

class ModelRestaurant {
  final String id;
  final String name;
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
}
