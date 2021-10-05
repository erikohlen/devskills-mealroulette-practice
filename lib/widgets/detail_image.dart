import 'package:flutter/material.dart';

class DetailImage extends StatelessWidget {
  final String imageUrl;
  const DetailImage(
    this.imageUrl, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.4,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
