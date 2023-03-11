import 'package:delivery_practice01/common/const/colors.dart';
import 'package:delivery_practice01/rating/model/model_rating.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class RatingCard extends StatelessWidget {
  //ImageProvider => network, asset 등
  //ImageProvider는 다른 위젯 안에 집어넣어야 한다.
  final ImageProvider avatarImage;
  final List<Image> images;
  final String email;
  final int rating;
  final String content;

  const RatingCard({
    required this.avatarImage,
    required this.images,
    required this.email,
    required this.rating,
    required this.content,
    Key? key,
  }) : super(key: key);

  factory RatingCard.fromModel({required ModelRating model}) {
    return RatingCard(
      avatarImage: NetworkImage(model.user.imageUrl),
      images: model.imgUrls.map((e) => Image.network(e)).toList(),
      email: model.user.username,
      rating: model.rating,
      content: model.content,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Header(
          rating: rating,
          email: email,
          avatarImage: avatarImage,
        ),
        const SizedBox(height: 5.0),
        _Body(content: content),
        const SizedBox(height: 5.0),
        if (images.isNotEmpty)
          SizedBox(
            height: 100.0,
            child: _Images(images: images),
          ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final ImageProvider avatarImage;
  final String email;
  final int rating;

  const _Header({
    Key? key,
    required this.avatarImage,
    required this.email,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 12.0,
          backgroundImage: avatarImage,
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            email,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
          ),
        ),
        ...List.generate(
          5,
          (index) => Icon(
            index < rating ? Icons.star : Icons.star_border_outlined,
            color: Color_Main,
          ),
        )
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final String content;

  const _Body({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            content,
            style: const TextStyle(color: Color_Text, fontSize: 14.0),
          ),
        )
      ],
    );
  }
}

class _Images extends StatelessWidget {
  final List<Image> images;

  const _Images({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: images
          .mapIndexed(
            (index, element) => Padding(
              padding: EdgeInsets.only(right: index == images.length - 1 ? 0 : 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: element,
              ),
            ),
          )
          .toList(),
    );
  }
}
