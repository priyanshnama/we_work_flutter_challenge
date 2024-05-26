// we_movies_events.dart

abstract class TopRatedMoviesEvent {}

class FetchTopRatedMoviesEvent extends TopRatedMoviesEvent {
  final String query;

  FetchTopRatedMoviesEvent(this.query);
}

class FetchMoreTopRatedMoviesEvent extends TopRatedMoviesEvent {
  final String query;

  FetchMoreTopRatedMoviesEvent(this.query);
}

class SearchTopRatedMoviesEvent extends TopRatedMoviesEvent {
  final String query;

  SearchTopRatedMoviesEvent(this.query);
}

abstract class NowPlayingMoviesEvent {}

class FetchNowPlayingMoviesEvent extends NowPlayingMoviesEvent {
  final String query;

  FetchNowPlayingMoviesEvent(this.query);
}

class FetchMoreNowPlayingMoviesEvent extends NowPlayingMoviesEvent {
  final String query;
  FetchMoreNowPlayingMoviesEvent(this.query);
}

class SearchNowPlayingMoviesEvent extends NowPlayingMoviesEvent {
  final String query;

  SearchNowPlayingMoviesEvent(this.query);
}
