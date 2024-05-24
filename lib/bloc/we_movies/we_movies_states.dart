// top_rated_movies_state.dart
import 'package:we_work_flutter_challenge/data/movie.dart';

abstract class TopRatedMoviesState {}

class TopRatedMoviesInitial extends TopRatedMoviesState {}

class TopRatedMoviesLoading extends TopRatedMoviesState {}

class TopRatedMoviesLoaded extends TopRatedMoviesState {
  final List<Movie> topRatedMovies;

  TopRatedMoviesLoaded(this.topRatedMovies);
}

class TopRatedMoviesError extends TopRatedMoviesState {
  final String message;
  TopRatedMoviesError(this.message);
}

// now_playing_movies_state.dart
abstract class NowPlayingMoviesState {}

class NowPlayingMoviesInitial extends NowPlayingMoviesState {}

class NowPlayingMoviesLoading extends NowPlayingMoviesState {}

class NowPlayingMoviesLoaded extends NowPlayingMoviesState {
  final List<Movie> nowPlayingMovies;

  NowPlayingMoviesLoaded(this.nowPlayingMovies);
}

class NowPlayingMoviesError extends NowPlayingMoviesState {
  final String message;
  NowPlayingMoviesError(this.message);
}
