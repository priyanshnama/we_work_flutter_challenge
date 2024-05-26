import 'package:flutter/material.dart';
import 'package:we_work_flutter_challenge/data/movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work_flutter_challenge/service/we_movies_repository.dart';

abstract class BaseMovieCard extends StatelessWidget {
  final Movie movie;

  const BaseMovieCard({super.key, required this.movie});

  String getPopularity() {
    if (movie.popularity < 1000) {
      return '${movie.popularity.toInt()}';
    }
    return '${(movie.popularity / 1000).toStringAsFixed(1)}K';
  }

  Widget buildImage(BuildContext context, {double? size}) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
        bottomLeft: Radius.circular(15),
        bottomRight: Radius.circular(15),
      ),
      child: Image.network(
        context.read<WeMoviesRepository>().getFullImageUrl(movie.backdropPath),
        fit: BoxFit.cover,
        width: double.infinity,
        height: size ?? double.infinity,
        loadingBuilder: (context, child, progress) {
          return progress == null
              ? child
              : const Center(child: CircularProgressIndicator());
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.white,
            child: const Center(child: Text("Unable to load image")),
          );
        },
      ),
    );
  }

  Widget buildTopBar(TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        children: [
          const Spacer(),
          buildRating(textTheme),
          const Spacer(),
          buildPopularity(),
          const SizedBox(width: 5),
          buildFavoriteIcon(),
        ],
      ),
    );
  }

  Widget buildRating(TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
    );
  }

  Widget buildPopularity() {
    return Container(
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
    );
  }

  Widget buildFavoriteIcon() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Icon(Icons.favorite_border_outlined,
          color: Colors.white, size: 16),
    );
  }

  @override
  Widget build(BuildContext context);
}
