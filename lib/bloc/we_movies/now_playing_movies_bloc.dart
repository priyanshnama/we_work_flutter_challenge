import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work_flutter_challenge/bloc/we_movies/we_movies_events.dart';
import 'package:we_work_flutter_challenge/bloc/we_movies/we_movies_states.dart';
import 'package:we_work_flutter_challenge/data/movie.dart';
import 'package:we_work_flutter_challenge/service/we_movies_repository.dart';

class NowPlayingMoviesBloc extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final WeMoviesRepository weMoviesRepository;
  int currentPage = 1;
  List<Movie> nowPlayingMovies = [];

  NowPlayingMoviesBloc(this.weMoviesRepository) : super(NowPlayingMoviesInitial()) {
    on<FetchNowPlayingMoviesEvent>((event, emit) async {
      emit(NowPlayingMoviesLoading());
      try {
        currentPage = 1;
        nowPlayingMovies = await weMoviesRepository.getNowPlayingMovies(page: currentPage);
        emit(NowPlayingMoviesLoaded(nowPlayingMovies));
      } catch (e) {
        emit(NowPlayingMoviesError(e.toString()));
      }
    });

    on<FetchMoreNowPlayingMoviesEvent>((event, emit) async {
      try {
        currentPage++;
        final moreMovies = await weMoviesRepository.getNowPlayingMovies(page: currentPage);
        nowPlayingMovies.addAll(moreMovies);
        emit(NowPlayingMoviesLoaded(nowPlayingMovies));
      } catch (e) {
        emit(NowPlayingMoviesError(e.toString()));
      }
    });
  }
}
