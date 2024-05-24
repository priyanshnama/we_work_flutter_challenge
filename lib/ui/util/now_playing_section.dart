import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:we_work_flutter_challenge/data/movie.dart';
import 'package:we_work_flutter_challenge/ui/util/now_playing_movie_cart.dart';

class NowPlayingSection extends StatelessWidget {
  final List<Movie> nowPlayingMovies;
  final Function(int, CarouselPageChangedReason) onPageChanged;

  const NowPlayingSection(
      {super.key, required this.nowPlayingMovies, required this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: nowPlayingMovies.length,
      itemBuilder: (context, index, realIndex) {
        return NowPlayingMovieCard(movie: nowPlayingMovies[index]);
      },
      options: CarouselOptions(
        onPageChanged: onPageChanged,
        height: 450,
        enableInfiniteScroll: false,
      ),
    );
  }
}
