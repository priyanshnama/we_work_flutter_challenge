import 'package:flutter/material.dart';
import 'package:we_work_flutter_challenge/ui/util/base_movie_card.dart';

class TopRatedMovieCard extends BaseMovieCard {
  const TopRatedMovieCard({super.key, required super.movie});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.all(10),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildImage(context, size: 180),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    maxLines: 1,
                    style: textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          color: Colors.grey, size: 16),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          movie.overview,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        '${(movie.voteCount / 1000).toStringAsFixed(1)} K Votes',
                        style: textTheme.bodyLarge,
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 1,
                        height: 15,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        movie.voteAverage.toStringAsFixed(2),
                        style: textTheme.bodyLarge,
                      ),
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
