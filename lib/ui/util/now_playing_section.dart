import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:we_work_flutter_challenge/data/movie.dart';
import 'package:we_work_flutter_challenge/ui/util/carousel_custom_indicator.dart';
import 'package:we_work_flutter_challenge/ui/cards/now_playing_movie_card.dart';
import 'package:we_work_flutter_challenge/ui/headers/section_header.dart';
import 'package:we_work_flutter_challenge/ui/headers/we_movies_header.dart';

class NowPlayingSection extends StatefulWidget {
  final List<Movie> nowPlayingMovies;
  final Function(int, CarouselPageChangedReason) onPageChanged;

  const NowPlayingSection({
    super.key,
    required this.nowPlayingMovies,
    required this.onPageChanged,
  });

  @override
  State<NowPlayingSection> createState() => _NowPlayingSectionState();
}

class _NowPlayingSectionState extends State<NowPlayingSection> {
  final ValueNotifier<int> _current = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: WeMoviesHeader(numberOfMovies: widget.nowPlayingMovies.length),
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SectionHeader(title: 'NOW PLAYING'),
        ),
        const SizedBox(height: 20),
        CarouselSlider.builder(
          itemCount: widget.nowPlayingMovies.length,
          itemBuilder: (context, index, realIndex) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: NowPlayingMovieCard(movie: widget.nowPlayingMovies[index]),
            );
          },
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              _current.value = index;
              widget.onPageChanged(index, reason);
            },
            height: 350,
            enableInfiniteScroll: false,
            viewportFraction: 0.8,
          ),
        ),
        const SizedBox(height: 20),
        ValueListenableBuilder(
          valueListenable: _current,
          builder: (context, value, child) {
            return CarouselCustomIndicator(
              current: value,
              totalSize: widget.nowPlayingMovies.length,
            );
          },
        )
      ],
    );
  }
}
