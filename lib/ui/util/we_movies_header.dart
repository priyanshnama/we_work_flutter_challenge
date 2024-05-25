import 'package:flutter/material.dart';
import 'package:we_work_flutter_challenge/ui/util/custom_shape_clipper.dart';

class WeMoviesHeader extends StatelessWidget {
  final int numberOfMovies;
  const WeMoviesHeader({super.key, required this.numberOfMovies});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Stack(
      children: [
        ClipPath(
          clipper: CustomShapeClipper(topHeight: 40, bottomHeight: 60),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: const Color.fromARGB(195, 198, 155, 211),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text('We Movies',
                    style: textTheme.headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text('$numberOfMovies Movies are loaded in now playing',
                    style: textTheme.bodySmall),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: Text('24TH APR 2024', style: textTheme.bodyMedium),
        ),
      ],
    );
  }
}
