import 'package:flutter/material.dart';

class CustomImageWidget extends StatelessWidget {
  String image;
  CustomImageWidget({this.image});
  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(image),
      fit: BoxFit.none,
    );
  }
}