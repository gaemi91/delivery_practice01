import 'package:delivery_practice01/common/const/data.dart';

class ModelRestaurantDetailProductCard {
  final String id;
  final String name;
  final String imgUrl;
  final String detail;
  final int price;

  const ModelRestaurantDetailProductCard({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price,
  });

  factory ModelRestaurantDetailProductCard.fromJson({required Map<String, dynamic> json}) {
    return ModelRestaurantDetailProductCard(
      id: json['id'],
      name: json['name'],
      imgUrl: 'http://$ip${json['imgUrl']}',
      detail: json['detail'],
      price: json['price'],
    );
  }
}
