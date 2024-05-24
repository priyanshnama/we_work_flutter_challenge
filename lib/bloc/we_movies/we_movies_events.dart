// we_movies_events.dart

abstract class TopRatedMoviesEvent {}

class FetchTopRatedMoviesEvent extends TopRatedMoviesEvent {}

class FetchMoreTopRatedMoviesEvent extends TopRatedMoviesEvent {}

abstract class NowPlayingMoviesEvent {}

class FetchNowPlayingMoviesEvent extends NowPlayingMoviesEvent {}

class FetchMoreNowPlayingMoviesEvent extends NowPlayingMoviesEvent {}
