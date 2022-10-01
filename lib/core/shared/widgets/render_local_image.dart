import 'package:flutter/material.dart';

class RenderLocalImage extends StatelessWidget {
  final String imagePath;
  final double? height;
  final double? width;
  final Color? color;
  const RenderLocalImage({
    required this.imagePath,
    this.height,
    this.width,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final extension = imagePath.split('.').last.toLowerCase();

    if (extension == 'svg') {
      return const SizedBox.shrink();
    }

    return Image.asset(
      imagePath,
      height: height,
      width: width,
      color: color,
    );
  }
}
