import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work_flutter_challenge/bloc/we_movies/now_playing_movies_bloc.dart';
import 'package:we_work_flutter_challenge/bloc/we_movies/top_rated_movies_bloc.dart';
import 'package:we_work_flutter_challenge/bloc/we_movies/we_movies_events.dart';
import 'package:we_work_flutter_challenge/bloc/we_movies/we_movies_states.dart';
import 'package:we_work_flutter_challenge/service/we_movies_repository.dart';
import 'package:we_work_flutter_challenge/ui/util/now_playing_section.dart';
import 'package:we_work_flutter_challenge/ui/util/section_header.dart';
import 'package:we_work_flutter_challenge/ui/util/top_rated_movie_card.dart';

class WeMovies extends StatefulWidget {
  const WeMovies({super.key});

  @override
  State<WeMovies> createState() => _WeMoviesState();
}

class _WeMoviesState extends State<WeMovies> {
  final _searchController = TextEditingController();
  late final TopRatedMoviesBloc topRatedMoviesBloc;
  late final NowPlayingMoviesBloc nowPlayingMoviesBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    topRatedMoviesBloc = TopRatedMoviesBloc(context.read<WeMoviesRepository>());
    nowPlayingMoviesBloc =
        NowPlayingMoviesBloc(context.read<WeMoviesRepository>());
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (topRatedMoviesBloc.state is TopRatedMoviesLoaded) {
        topRatedMoviesBloc
            .add(FetchMoreTopRatedMoviesEvent(_searchController.text));
      }
    }
  }

  void _onSearch(String query) {
    topRatedMoviesBloc.add(SearchTopRatedMoviesEvent(query));
    nowPlayingMoviesBloc.add(SearchNowPlayingMoviesEvent(query));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => topRatedMoviesBloc
              ..add(FetchTopRatedMoviesEvent(_searchController.text))),
        BlocProvider(
            create: (context) => nowPlayingMoviesBloc
              ..add(FetchNowPlayingMoviesEvent(_searchController.text))),
      ],
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RefreshIndicator(
            onRefresh: () async {
              topRatedMoviesBloc
                  .add(FetchTopRatedMoviesEvent(_searchController.text));
              nowPlayingMoviesBloc
                  .add(FetchNowPlayingMoviesEvent(_searchController.text));
            },
            child: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(12.0),
                  sliver: SliverToBoxAdapter(
                    child: _buildSearchBar(),
                  ),
                ),
                SliverToBoxAdapter(child: _buildNowPlayingSection()),
                const SliverToBoxAdapter(
                    child: SectionHeader(title: 'TOP RATED')),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  sliver: _buildTopRatedSection(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      onChanged: _onSearch,
      decoration: const InputDecoration(
        hintText: 'Search Movies by name ...',
        prefixIcon: Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      ),
    );
  }

  Widget _buildNowPlayingSection() {
    return BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
      builder: (context, state) {
        if (state is NowPlayingMoviesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NowPlayingMoviesLoaded) {
          final nowPlayingMovies = state.nowPlayingMovies;
          return NowPlayingSection(
            onPageChanged: (index, reason) {
              if (index == nowPlayingMovies.length - 1) {
                nowPlayingMoviesBloc.add(
                    FetchMoreNowPlayingMoviesEvent(_searchController.text));
              }
            },
            nowPlayingMovies: nowPlayingMovies,
          );
        } else if (state is NowPlayingMoviesError) {
          return Center(child: Text(state.message));
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildTopRatedSection() {
    return BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
      builder: (context, state) {
        if (state is TopRatedMoviesLoading) {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is TopRatedMoviesLoaded) {
          final topRatedMovies = state.topRatedMovies;
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return TopRatedMovieCard(movie: topRatedMovies[index]);
              },
              childCount: topRatedMovies.length,
            ),
          );
        } else if (state is TopRatedMoviesError) {
          return SliverToBoxAdapter(
            child: Center(child: Text(state.message)),
          );
        } else {
          return const SliverToBoxAdapter(child: SizedBox());
        }
      },
    );
  }
}
