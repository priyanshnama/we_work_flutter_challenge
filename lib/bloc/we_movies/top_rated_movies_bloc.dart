import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work_flutter_challenge/bloc/we_movies/we_movies_events.dart';
import 'package:we_work_flutter_challenge/bloc/we_movies/we_movies_states.dart';
import 'package:we_work_flutter_challenge/service/we_movies_repository.dart';

class TopRatedMoviesBloc extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final WeMoviesRepository weMoviesRepository;

  TopRatedMoviesBloc(this.weMoviesRepository) : super(TopRatedMoviesInitial()) {
    on<FetchTopRatedMoviesEvent>((event, emit) async {
      emit(TopRatedMoviesLoading());
      try {
        final topRatedMovies = await weMoviesRepository.getTopRatedMovies();
        emit(TopRatedMoviesLoaded(topRatedMovies));
      } catch (e) {
        emit(TopRatedMoviesError(e.toString()));
      }
    });
  }
}
