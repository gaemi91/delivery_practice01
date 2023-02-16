import 'package:delivery_practice01/common/const/colors.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            child: Image.asset('asset/img/food/ddeok_bok_gi.jpg', fit: BoxFit.cover, width: 110, height: 110),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '떡볶이',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                Text(
                  '전통 떡볶이의 정석! 원하는 대로 맵기를 선택하고 추억의 떡볶이맛에 빠져 봅시다!!!!!',
                  style: TextStyle(color: Color_Text),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text('₩1000', style: TextStyle(color: Color_Main), textAlign: TextAlign.right),
              ],
            ),
          )
        ],
      ),
    );
  }
}
