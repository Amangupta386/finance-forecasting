import 'package:flutter/material.dart';

/// A custom Flutter widget for displaying an image from the assets directory.
class ImageAsset extends StatelessWidget {
  final String imageName;
  final double? width;

  /// - [imageName]: The name of the image file in the assets directory.
  /// - [width]: The width of the displayed image. Can be null to use the default width.
  const ImageAsset({
    required this.imageName,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Construct the full asset path for the image.
    String path = 'assets/images/$imageName';

    // Display the image using the Image.asset widget.
    return Image.asset(
      path,
      width: width, // Optionally set the width of the displayed image.
    );
  }
}
