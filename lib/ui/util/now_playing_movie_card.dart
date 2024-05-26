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
            clipper: CustomShapeClipper(
                topHeight: 40, bottomHeight: 60, topBarOffset: -20),
            child: Image.network(
              context
                  .read<WeMoviesRepository>()
                  .getFullImageUrl(movie.backdropPath, size: 'w780'),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.white,
                  child: const Text("Unable to load image")
                );
              },
            )),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Row(
                children: [
                  const Spacer(),
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
                        const Icon(Icons.remove_red_eye_outlined,
                            color: Colors.white, size: 16),
                        const SizedBox(width: 5),
                        Text(
                          '${movie.popularity.toInt()}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.favorite_border_outlined,
                        color: Colors.white, size: 16),
                  ),
                ],
              ),
            ),
            const Spacer(),
            ClipPath(
                clipper: CustomShapeClipper(
                    topHeight: 40, bottomHeight: 60, topBarOffset: 20),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 90,
                            ),
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
                        const SizedBox(height: 20),
                        Text(
                          movie.title,
                          maxLines: 1,
                          style: textTheme.bodyLarge?.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              size: 16,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2 - 35,
                              child: Text(
                                movie.overview,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.bodySmall
                                    ?.copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${movie.voteCount} Votes',
                          style: textTheme.bodyMedium?.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        )
      ],
    );
  }
}
