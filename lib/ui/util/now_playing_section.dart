import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:we_work_flutter_challenge/data/movie.dart';
import 'package:we_work_flutter_challenge/ui/util/gradient_line.dart';
import 'package:we_work_flutter_challenge/ui/util/now_playing_movie_card.dart';
import 'package:we_work_flutter_challenge/ui/util/we_movies_header.dart';

class NowPlayingSection extends StatelessWidget {
  final List<Movie> nowPlayingMovies;
  final Function(int, CarouselPageChangedReason) onPageChanged;

  const NowPlayingSection(
      {super.key, required this.nowPlayingMovies, required this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: WeMoviesHeader(numberOfMovies : nowPlayingMovies.length),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text("NOW PLAYING"),
            GradientLine(Colors.black),
          ],
        ),
        CarouselSlider.builder(
          itemCount: nowPlayingMovies.length,
          itemBuilder: (context, index, realIndex) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: NowPlayingMovieCard(movie: nowPlayingMovies[index]),
            );
          },
          options: CarouselOptions(
            onPageChanged: onPageChanged,
            height: 350,
            enableInfiniteScroll: false,
            viewportFraction: 0.8
          ),
        ),
      ],
    );
  }
}
