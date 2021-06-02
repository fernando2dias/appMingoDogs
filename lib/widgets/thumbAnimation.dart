import 'package:flutter/material.dart';

class ThumbAnimation extends StatelessWidget {
  final String thumbImage;
  final double width;

  const ThumbAnimation({Key key, this.thumbImage, this.width}) : super(key: key);

  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: thumbImage,
        child: Image.network(thumbImage,
        fit: BoxFit.contain,
        ),
      ),
    );
  }
}
