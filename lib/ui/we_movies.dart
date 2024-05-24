import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work_flutter_challenge/bloc/we_movies/now_playing_movies_bloc.dart';
import 'package:we_work_flutter_challenge/bloc/we_movies/top_rated_movies_bloc.dart';
import 'package:we_work_flutter_challenge/bloc/we_movies/we_movies_events.dart';
import 'package:we_work_flutter_challenge/bloc/we_movies/we_movies_states.dart';
import 'package:we_work_flutter_challenge/service/we_movies_repository.dart';
import 'package:we_work_flutter_challenge/ui/util/gradient_line.dart';
import 'package:we_work_flutter_challenge/ui/util/now_playing_section.dart';
import 'package:we_work_flutter_challenge/ui/util/top_rated_movie_card.dart';

class WeMovies extends StatefulWidget {
  const WeMovies({super.key});

  @override
  State<WeMovies> createState() => _WeMoviesState();
}

class _WeMoviesState extends State<WeMovies> {
  final _searchController = TextEditingController();
  late final TopRatedMoviesBloc topRatedMoviesBloc;
  late final NowPlayingMoviesBloc nowPlayingMoviesBloc;
  final ScrollController _horizontalScrollController = ScrollController();

  @override
  void initState() {
    topRatedMoviesBloc = TopRatedMoviesBloc(context.read<WeMoviesRepository>());
    nowPlayingMoviesBloc = NowPlayingMoviesBloc(context.read<WeMoviesRepository>());

    _horizontalScrollController.addListener(_onVerticalScroll);

    super.initState();
  }

  void _onVerticalScroll() {
    if (_horizontalScrollController.position.pixels == _horizontalScrollController.position.maxScrollExtent) {
      if (topRatedMoviesBloc.state is TopRatedMoviesLoaded) {
        topRatedMoviesBloc.add(FetchMoreTopRatedMoviesEvent());
      }
    }
  }

  @override
  void dispose() {
    _horizontalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              topRatedMoviesBloc..add(FetchTopRatedMoviesEvent()),
        ),
        BlocProvider(
          create: (context) =>
              nowPlayingMoviesBloc..add(FetchNowPlayingMoviesEvent()),
        ),
      ],
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RefreshIndicator(
            onRefresh: () async {
              topRatedMoviesBloc.add(FetchTopRatedMoviesEvent());
              nowPlayingMoviesBloc.add(FetchNowPlayingMoviesEvent());
            },
            child: SingleChildScrollView(
              controller: _horizontalScrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // Search bar
                  TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search Movies by name ...',
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Now Playing section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("NOW PLAYING"),
                      GradientLine(Colors.black),
                    ],
                  ),
                  BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
                    builder: (context, state) {
                      if (state is NowPlayingMoviesLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is NowPlayingMoviesLoaded) {
                        final nowPlayingMovies = state.nowPlayingMovies;
                        return NowPlayingSection(
                          onPageChanged: (index, reason) {
                              if (index == nowPlayingMovies.length - 1) {
                                nowPlayingMoviesBloc.add(FetchMoreNowPlayingMoviesEvent());
                              }
                            },
                            nowPlayingMovies: nowPlayingMovies);
                      } else if (state is NowPlayingMoviesError) {
                        return Center(child: Text(state.message));
                      } else {
                        return Container();
                      }
                    },
                  ),
                  const SizedBox(height: 20),

                  // Top Rated section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("TOP RATED"),
                      GradientLine(Colors.black),
                    ],
                  ),
                  BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
                    builder: (context, state) {
                      if (state is TopRatedMoviesLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is TopRatedMoviesLoaded) {
                        final topRatedMovies = state.topRatedMovies;
                        return Column(
                          children: topRatedMovies
                              .map((movie) => TopRatedMovieCard(movie: movie))
                              .toList(),
                        );
                      } else if (state is TopRatedMoviesError) {
                        return Center(child: Text(state.message));
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
