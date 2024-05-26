import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work_flutter_challenge/bloc/we_movies/we_movies_events.dart';
import 'package:we_work_flutter_challenge/bloc/we_movies/we_movies_states.dart';
import 'package:we_work_flutter_challenge/data/movie.dart';
import 'package:we_work_flutter_challenge/service/we_movies_repository.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final WeMoviesRepository weMoviesRepository;
  int currentPage = 1;
  List<Movie> topRatedMovies = [];
  bool isLoading = false;

  TopRatedMoviesBloc(this.weMoviesRepository) : super(TopRatedMoviesInitial()) {
    on<FetchTopRatedMoviesEvent>((event, emit) async {
      emit(TopRatedMoviesLoading());
      try {
        currentPage = 1;
        topRatedMovies =
            await weMoviesRepository.getTopRatedMovies(page: currentPage);
        emit(TopRatedMoviesLoaded(topRatedMovies));
      } catch (e) {
        emit(TopRatedMoviesError(e.toString()));
      }
    });

    on<FetchMoreTopRatedMoviesEvent>((event, emit) async {
      if (isLoading) return;

      try {
        isLoading = true;
        currentPage++;
        final moreMovies =
            await weMoviesRepository.getTopRatedMovies(page: currentPage);
        topRatedMovies.addAll(moreMovies);
        emit(TopRatedMoviesLoaded(topRatedMovies));
      } catch (e) {
        emit(TopRatedMoviesError(e.toString()));
      } finally {
        isLoading = false;
      }
    });
  }
}
