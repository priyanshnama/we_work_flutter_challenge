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
  bool isFetching = false;

  TopRatedMoviesBloc(this.weMoviesRepository) : super(TopRatedMoviesInitial()) {
    on<FetchTopRatedMoviesEvent>((event, emit) async {
      emit(TopRatedMoviesLoading());
      try {
        currentPage = 1;
        topRatedMovies =
            await weMoviesRepository.getTopRatedMovies(page: currentPage);
        if (event.query.isEmpty) {
          emit(TopRatedMoviesLoaded(topRatedMovies));
        }
        final filteredMovies = topRatedMovies
            .where((movie) =>
                movie.title.toLowerCase().contains(event.query.toLowerCase()))
            .toList();
        emit(TopRatedMoviesLoaded(filteredMovies));
      } catch (e) {
        emit(TopRatedMoviesError(e.toString()));
      }
    });

    on<FetchMoreTopRatedMoviesEvent>((event, emit) async {
      if (isFetching) return;
      try {
        isFetching = true;
        currentPage++;
        final moreMovies =
            await weMoviesRepository.getTopRatedMovies(page: currentPage);
        topRatedMovies.addAll(moreMovies);
        if (event.query.isEmpty) {
          emit(TopRatedMoviesLoaded(topRatedMovies));
        }
        final filteredMovies = topRatedMovies
            .where((movie) =>
                movie.title.toLowerCase().contains(event.query.toLowerCase()))
            .toList();
        emit(TopRatedMoviesLoaded(filteredMovies));
      } catch (e) {
        emit(TopRatedMoviesError(e.toString()));
      } finally {
        isFetching = false;
      }
    });

    on<SearchTopRatedMoviesEvent>((event, emit) {
      final filteredMovies = topRatedMovies
          .where((movie) =>
              movie.title.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      if (filteredMovies.isEmpty) {
        emit(TopRatedMoviesError("No results found"));
      } else {
        emit(TopRatedMoviesLoaded(filteredMovies));
      }
    });
  }
}
