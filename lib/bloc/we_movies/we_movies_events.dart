// top_rated_movies_event.dart
abstract class TopRatedMoviesEvent {}

class FetchTopRatedMoviesEvent extends TopRatedMoviesEvent {}

// now_playing_movies_event.dart
abstract class NowPlayingMoviesEvent {}

class FetchNowPlayingMoviesEvent extends NowPlayingMoviesEvent {}
