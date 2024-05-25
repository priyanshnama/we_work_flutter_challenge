import 'package:flutter/material.dart';
import 'package:we_work_flutter_challenge/data/movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work_flutter_challenge/service/we_movies_repository.dart';

class TopRatedMovieCard extends StatelessWidget {
  final Movie movie;

  const TopRatedMovieCard({super.key, required this.movie});

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
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  child: FutureBuilder<String>(
                    future: context
                        .read<WeMoviesRepository>()
                        .getFullImageUrl(movie.backdropPath),
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
                          height: 180,
                        );
                      } else {
                        return const Center(
                          child: Text('No image available'),
                        );
                      }
                    },
                  ),
                ),
                Positioned(
                  left: 10,
                  bottom: 30,
                  child: Container(
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
                          '${(movie.popularity / 1000).toStringAsFixed(1)}K',
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
                    style: textTheme.headlineMedium,
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
