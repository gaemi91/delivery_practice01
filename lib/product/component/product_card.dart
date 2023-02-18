import 'package:delivery_practice01/common/const/colors.dart';
import 'package:delivery_practice01/common/const/data.dart';
import 'package:delivery_practice01/restaurant/component/restaurant_card.dart';
import 'package:delivery_practice01/restaurant/model/model_restaurant_detail_product.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String id;
  final String name;
  final String imgUrl;
  final String detail;
  final int price;

  const ProductCard({
    Key? key,
    required this.id,
    required this.imgUrl,
    required this.detail,
    required this.price,
    required this.name,
  }) : super(key: key);

  factory ProductCard.fromModel({required ModelRestaurantDetailProduct model}) {
    return ProductCard(
      id: model.id,
      imgUrl: model.imgUrl,
      detail: model.detail,
      price: model.price,
      name: model.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            child: Image.network(
              imgUrl,
              fit: BoxFit.cover,
              width: 110,
              height: 110,
            ),
          ),
          const SizedBox(width: 5.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                Text(
                  detail,
                  style: const TextStyle(color: Color_Text),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text('₩$price', style: const TextStyle(color: Color_Main), textAlign: TextAlign.right),
              ],
            ),
          )
        ],
      ),
    );
  }
}
