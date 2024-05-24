import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work_flutter_challenge/bloc/we_movies/we_movies_events.dart';
import 'package:we_work_flutter_challenge/bloc/we_movies/we_movies_states.dart';
import 'package:we_work_flutter_challenge/service/we_movies_repository.dart';

class NowPlayingMoviesBloc extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final WeMoviesRepository weMoviesRepository;

  NowPlayingMoviesBloc(this.weMoviesRepository) : super(NowPlayingMoviesInitial()) {
    on<FetchNowPlayingMoviesEvent>((event, emit) async {
      emit(NowPlayingMoviesLoading());
      try {
        final nowPlayingMovies = await weMoviesRepository.getNowPlayingMovies();
        emit(NowPlayingMoviesLoaded(nowPlayingMovies));
      } catch (e) {
        emit(NowPlayingMoviesError(e.toString()));
      }
    });
  }
}
