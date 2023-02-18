import 'package:delivery_practice01/common/const/colors.dart';
import 'package:delivery_practice01/restaurant/model/model_restaurant_card.dart';
import 'package:delivery_practice01/restaurant/model/model_restaurant_detail.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final Widget image;
  final String name;
  final List<String> tags;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;
  final bool isDetail;
  final String? detail;

  const RestaurantCard({
    required this.image,
    required this.name,
    required this.tags,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
    this.isDetail = false,
    this.detail,
    Key? key,
  }) : super(key: key);

  factory RestaurantCard.fromModel({required ModelRestaurantCard model, bool isDetail = false}) {
    return RestaurantCard(
      image: Image.network(model.thumbUrl, fit: BoxFit.cover),
      name: model.name,
      tags: model.tags,
      ratings: model.ratings,
      ratingsCount: model.ratingsCount,
      deliveryTime: model.deliveryTime,
      deliveryFee: model.deliveryFee,
      isDetail: isDetail,
      detail: model is ModelRestaurantDetail ? model.detail : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (isDetail) image,
        if (!isDetail)
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            child: image,
          ),
        const SizedBox(height: 10.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDetail ? 10.0 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
              ),
              Text(
                tags.join(' · '),
                style: const TextStyle(color: Color_Text, fontSize: 16.0),
              ),
              const SizedBox(height: 3.0),
              Row(
                children: [
                  _Info(iconData: Icons.star, label: '$ratings'),
                  renderDot(),
                  _Info(iconData: Icons.receipt, label: '$ratingsCount'),
                  renderDot(),
                  _Info(iconData: Icons.timelapse, label: '$deliveryTime분'),
                  renderDot(),
                  _Info(iconData: Icons.monetization_on, label: deliveryFee == 0 ? '무료' : '$deliveryFee'),
                ],
              ),
              if (isDetail && detail != null) Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(detail!),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget renderDot() {
    return const Text(
      ' · ',
      style: TextStyle(color: Color_Main, fontWeight: FontWeight.w600),
    );
  }
}

class _Info extends StatelessWidget {
  final IconData iconData;
  final String label;

  const _Info({Key? key, required this.iconData, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData, color: Color_Main, size: 16.0),
        const SizedBox(width: 3.0),
        Text(label, style: const TextStyle(color: Color_Main, fontSize: 14.0)),
      ],
    );
  }
}
