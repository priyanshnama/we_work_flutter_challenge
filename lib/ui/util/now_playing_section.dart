import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:we_work_flutter_challenge/data/movie.dart';
import 'package:we_work_flutter_challenge/ui/util/gradient_line.dart';
import 'package:we_work_flutter_challenge/ui/util/now_playing_movie_card.dart';
import 'package:we_work_flutter_challenge/ui/util/we_movies_header.dart';

class NowPlayingSection extends StatefulWidget {
  final List<Movie> nowPlayingMovies;
  final Function(int, CarouselPageChangedReason) onPageChanged;

  const NowPlayingSection({
    Key? key,
    required this.nowPlayingMovies,
    required this.onPageChanged,
  }) : super(key: key);

  @override
  State<NowPlayingSection> createState() => _NowPlayingSectionState();
}

class _NowPlayingSectionState extends State<NowPlayingSection> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: WeMoviesHeader(numberOfMovies: widget.nowPlayingMovies.length),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text("NOW PLAYING"),
            GradientLine(Colors.black),
          ],
        ),
        CarouselSlider.builder(
          itemCount: widget.nowPlayingMovies.length,
          itemBuilder: (context, index, realIndex) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: NowPlayingMovieCard(movie: widget.nowPlayingMovies[index]),
            );
          },
          carouselController: _controller,
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
              widget.onPageChanged(index, reason);
            },
            height: 350,
            enableInfiniteScroll: false,
            viewportFraction: 0.8,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_current > 0)
              GestureDetector(
                onTap: () => _controller.animateToPage(_current - 1),
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(0.4),
                  ),
                ),
              ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${_current + 1}/${widget.nowPlayingMovies.length}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            if (_current < widget.nowPlayingMovies.length - 1)
              Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(0.4),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
