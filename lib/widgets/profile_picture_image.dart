import 'package:flutter/material.dart';

class ProfilePictureImage extends StatelessWidget {
  final String image;
  final double x;
  final double y;

  const ProfilePictureImage({
    super.key, required this.image, required this.x, required this.y,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100.0),

      child: Image.asset(
        image,
        fit: BoxFit.cover,
        height: x,
        width: y,

      ),
    );
  }
}
