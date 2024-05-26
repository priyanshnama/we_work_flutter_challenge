import 'package:flutter/material.dart';
import 'package:we_work_flutter_challenge/ui/cards/base_movie_card.dart';

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
            Stack(
              children: [
                buildImage(context, size: 180),
                Positioned(
                  left: 10,
                  bottom: 30,
                  child: Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.grey[500],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      children: [
                        const Icon(Icons.remove_red_eye_outlined,
                            color: Colors.white, size: 16),
                        const SizedBox(width: 5),
                        Text(
                          getPopularity(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
