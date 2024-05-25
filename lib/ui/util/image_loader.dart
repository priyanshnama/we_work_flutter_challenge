import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_work_flutter_challenge/service/we_movies_repository.dart';

class ImageLoader extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final BoxFit fit;
  final BorderRadius borderRadius;

  const ImageLoader({
    required this.imagePath,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: FutureBuilder<String>(
        future: context.read<WeMoviesRepository>().getFullImageUrl(imagePath),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: SizedBox(
                height: height,
                width: width,
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          } else if (snapshot.hasData) {
            return Image.network(
              snapshot.requireData,
              fit: fit,
              width: width,
              height: height,
            );
          } else {
            return const Center(
              child: Text('No image available'),
            );
          }
        },
      ),
    );
  }
}
