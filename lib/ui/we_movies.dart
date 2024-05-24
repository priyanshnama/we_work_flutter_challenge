import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work_flutter_challenge/service/we_movies_repository.dart';
import 'package:we_work_flutter_challenge/ui/util/gradient_line.dart';
import 'package:we_work_flutter_challenge/bloc/we_movies_bloc.dart';

class WeMovies extends StatefulWidget {
  const WeMovies({super.key});

  @override
  State<WeMovies> createState() => _WeMoviesState();
}

class _WeMoviesState extends State<WeMovies> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeMoviesBloc(WeMoviesRepository())
        ..add(FetchTopRatedMoviesEvent())
        ..add(FetchNowPlayingMoviesEvent()),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
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
              BlocBuilder<WeMoviesBloc, WeMoviesState>(
                builder: (context, state) {
                  if (state is NowPlayingMoviesLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is NowPlayingMoviesLoaded) {
                    final nowPlayingMovies = state.nowPlayingMovies;
                    return Container(child: Text(nowPlayingMovies.length.toString()));
                  } else if (state is WeMoviesError) {
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
              BlocBuilder<WeMoviesBloc, WeMoviesState>(
                builder: (context, state) {
                  print(state);
                  if (state is TopRatedMoviesLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is TopRatedMoviesLoaded) {
                    final topRatedMovies = state.topRatedMovies;
                    return Container(child: Text(topRatedMovies.length.toString()));
                  } else if (state is WeMoviesError) {
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
    );
  }
}