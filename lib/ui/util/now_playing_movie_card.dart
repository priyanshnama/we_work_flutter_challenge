import 'package:flutter/material.dart';
import 'package:we_work_flutter_challenge/data/movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work_flutter_challenge/service/we_movies_repository.dart';
import 'package:we_work_flutter_challenge/ui/util/custom_shape_clipper.dart';

class NowPlayingMovieCard extends StatelessWidget {
  final Movie movie;

  const NowPlayingMovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        ClipPath(
          clipper: CustomShapeClipper(topHeight: 40, bottomHeight: 60),
          child: FutureBuilder<String>(
            future: context
                .read<WeMoviesRepository>()
                .getFullImageUrl(movie.backdropPath, size: 'w780'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: SizedBox(
                      height: 250,
                      width: 250,
                      child: Text('Error: ${snapshot.error}')),
                );
              } else if (snapshot.hasData) {
                return Image.network(
                  snapshot.requireData,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                );
              } else {
                return const Center(
                  child: Text('No image available'),
                );
              }
            },
          ),
        ),
        Column(
          children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    children: [
                      Text(
                        movie.voteAverage.toStringAsFixed(2),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.remove_red_eye,
                          color: Colors.white, size: 16),
                      const SizedBox(width: 5),
                      Text(
                        '${movie.popularity.toInt()}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            ClipPath(
                clipper: CustomShapeClipper(topHeight: 40, bottomHeight: 60),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.8)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.language,
                              color: Colors.white, size: 16),
                          const SizedBox(width: 5),
                          Text(
                            movie.originalLanguage.toUpperCase(),
                            style: textTheme.bodySmall
                                ?.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        movie.title,
                        style: textTheme.headlineMedium
                            ?.copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        movie.overview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            textTheme.bodyMedium?.copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${movie.voteCount} Votes',
                        style:
                            textTheme.bodyLarge?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ))
          ],
        )
      ],
    );
  }
}
