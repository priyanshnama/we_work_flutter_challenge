import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work_flutter_challenge/data/movie.dart';
import 'package:we_work_flutter_challenge/service/we_movies_repository.dart';

abstract class WeMoviesEvent {}

class FetchTopRatedMoviesEvent extends WeMoviesEvent {}

class FetchNowPlayingMoviesEvent extends WeMoviesEvent {}

abstract class WeMoviesState {}

class WeMoviesInitial extends WeMoviesState {}

class TopRatedMoviesLoading extends WeMoviesState {}

class NowPlayingMoviesLoading extends WeMoviesState {}

class TopRatedMoviesLoaded extends WeMoviesState {
  final List<Movie> topRatedMovies;

  TopRatedMoviesLoaded(this.topRatedMovies);
}

class NowPlayingMoviesLoaded extends WeMoviesState {
  final List<Movie> nowPlayingMovies;

  NowPlayingMoviesLoaded(this.nowPlayingMovies);
}

class WeMoviesError extends WeMoviesState {
  final String message;
  WeMoviesError(this.message);
}

class WeMoviesBloc extends Bloc<WeMoviesEvent, WeMoviesState> {
  final WeMoviesRepository weMoviesRepository;

  WeMoviesBloc(this.weMoviesRepository) : super(WeMoviesInitial()) {
    on<FetchTopRatedMoviesEvent>((event, emit) async {
      emit(TopRatedMoviesLoading());
      try {
        final topRatedMovies = await weMoviesRepository.getTopRatedMovies();
        emit(TopRatedMoviesLoaded(topRatedMovies));
      } catch (e) {
        emit(WeMoviesError(e.toString()));
      }
    });

    on<FetchNowPlayingMoviesEvent>((event, emit) async {
      emit(NowPlayingMoviesLoading());
      try {
        final nowPlayingMovies = await weMoviesRepository.getNowPlayingMovies();
        emit(NowPlayingMoviesLoaded(nowPlayingMovies));
      } catch (e) {
        emit(WeMoviesError(e.toString()));
      }
    });
  }
}
