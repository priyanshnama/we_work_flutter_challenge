import 'package:flutter/material.dart';
import 'package:we_work_flutter_challenge/data/movie.dart';

class TopRatedMovieCard extends StatelessWidget {
  final Movie movie;

  const TopRatedMovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.all(10),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 180,
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    children: [
                      const Icon(Icons.remove_red_eye, color: Colors.white, size: 16),
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
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.grey, size: 16),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        movie.overview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      '${(movie.voteCount / 1000).toStringAsFixed(1)} K Votes',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      movie.voteAverage.toStringAsFixed(2),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
