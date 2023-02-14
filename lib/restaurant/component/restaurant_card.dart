import 'package:delivery_practice01/common/const/colors.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final Widget image;
  final String name;
  final List<String> tags;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  const RestaurantCard({
    required this.image,
    required this.name,
    required this.tags,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          child: image,
        ),
        const SizedBox(height: 10.0),
        Text(name, style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)),
        const SizedBox(height: 2.0),
        Text(tags.join(" · "), style: const TextStyle(color: Color_Text, fontSize: 15.0)),
        const SizedBox(height: 2.0),
        Row(
          children: [
            _IconData(iconData: Icons.star, label: '$ratings'),
            renderDot(),
            _IconData(iconData: Icons.receipt, label: '$ratingsCount'),
            renderDot(),
            _IconData(iconData: Icons.timelapse, label: '$deliveryTime분'),
            renderDot(),
            _IconData(iconData: Icons.monetization_on, label: '$deliveryFee'),
          ],
        )
      ],
    );
  }

  Widget renderDot() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.0),
      child: Text(' · ',
          style: TextStyle(
            color: Color_Main,
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
          )),
    );
  }
}

class _IconData extends StatelessWidget {
  final IconData iconData;
  final String label;

  const _IconData({
    required this.iconData,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData, color: Color_Main, size: 15.0),
        const SizedBox(width: 3.0),
        Text(label, style: const TextStyle(color: Color_Main, fontSize: 14.0)),
      ],
    );
  }
}