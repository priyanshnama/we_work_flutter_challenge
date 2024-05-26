// we_movies_events.dart

abstract class TopRatedMoviesEvent {}

class FetchTopRatedMoviesEvent extends TopRatedMoviesEvent {}

class FetchMoreTopRatedMoviesEvent extends TopRatedMoviesEvent {}

class SearchTopRatedMoviesEvent extends TopRatedMoviesEvent {
  final String query;

  SearchTopRatedMoviesEvent(this.query);
}

abstract class NowPlayingMoviesEvent {}

class FetchNowPlayingMoviesEvent extends NowPlayingMoviesEvent {}

class FetchMoreNowPlayingMoviesEvent extends NowPlayingMoviesEvent {}

class SearchNowPlayingMoviesEvent extends NowPlayingMoviesEvent {
  final String query;

  SearchNowPlayingMoviesEvent(this.query);
}
