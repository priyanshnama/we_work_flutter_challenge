import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work_flutter_challenge/data/we_movies_repository.dart';
import 'package:we_work_flutter_challenge/ui/util/gradient_line.dart';
import 'package:we_work_flutter_challenge/ui/we_movies/we_movies_bloc.dart';

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
              // search bar
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
      
              const SizedBox(
                height: 20,
              ),
      
              // now playing
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [const Text("NOW PLAYING"), GradientLine(Colors.black)],
              ),
      
              BlocBuilder<WeMoviesBloc, WeMoviesState>(
                builder: (context, state) {
                  if (state is WeMoviesLoading) {
                    return CircularProgressIndicator();
                  } else if (state is NowPlayingMoviesLoaded) {
                    final nowPlayingMovies = state.nowPlayingMovies;
                    return Container();
                  } else if (state is WeMoviesError) {
                    return Text(state.message);
                  } else {
                    return Container();
                  }
                },
              ),
      
              const SizedBox(
                height: 20,
              ),
      
              //top rated
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [const Text("TOP RATED"), GradientLine(Colors.black)],
              ),
      
              BlocBuilder<WeMoviesBloc, WeMoviesState>(
                builder: (context, state) {
                  if (state is WeMoviesLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is TopRatedMoviesLoaded) {
                    final topRatedMovies = state.topRatedMovies;
                    return Container();
                  } else if (state is WeMoviesError) {
                    return Text(state.message);
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
