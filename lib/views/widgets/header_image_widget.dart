import 'package:flutter/material.dart';

/// ImageSection: hero banner using a local asset, with a caption overlay.
/// Pass [height] in portrait; leave it null in landscape so it fills its parent.
class HeaderImageWidget extends StatelessWidget {
  const HeaderImageWidget({
    super.key,
    required this.imageSource,
    required this.caption,
    this.height,
  });

  /// Asset path, e.g. 'assets/images/rajang_river.jpg'
  final String imageSource;
  final String caption;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            imageSource,
            fit: BoxFit.cover,
            semanticLabel: caption,
            // Shown only if the asset is missing or not registered in pubspec.yaml
            errorBuilder: (_, __, ___) => Container(
              color: Colors.blueGrey.shade700,
              alignment: Alignment.center,
              child: const Icon(
                Icons.broken_image,
                size: 48,
                color: Colors.white70,
              ),
            ),
          ),

          // Dark gradient behind the caption for readability
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 10),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black87],
                ),
              ),
              child: Text(
                caption,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}