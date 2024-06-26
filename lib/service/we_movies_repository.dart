import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:we_work_flutter_challenge/data/movie.dart';

class WeMoviesRepository {
  static final WeMoviesRepository _instance = WeMoviesRepository._internal();

  factory WeMoviesRepository() => _instance;

  WeMoviesRepository._internal();

  static const String _apiKey =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2YTg3ZTY4MDMyODIwMTIzZmQ0Yzg0YjQzNDhjYjc3ZCIsInN1YiI6IjY2Mjg5NDExOTFmMGVhMDE0YjAwOWU1ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6zIM73Giwg5M4wP6MX8KDCpee7IMnpnLTZUyMpETb08';
  static const String _baseUrl = 'https://api.themoviedb.org/3/movie';
  static const Map<String, String> _headers = {
    'Authorization': 'Bearer $_apiKey',
    'accept': 'application/json',
  };

  final String _secureBaseUrl = 'https://image.tmdb.org/t/p/';
  final List<String> _posterSizes = [
    "w92",
    "w154",
    "w185",
    "w342",
    "w500",
    "w780",
    "original"
  ];
  final Box _cacheBox = Hive.box('moviesCache');

  Future<List<Movie>> _fetchMovies(String endpoint) async {
    final response = await http.get(Uri.parse(endpoint), headers: _headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> moviesJson = data['results'];
      return moviesJson.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies from $endpoint');
    }
  }

  Future<List<Movie>> getTopRatedMovies({int page = 1}) async {
    final cacheKey = 'topRatedMovies_page_$page';
    final cachedData = _cacheBox.get(cacheKey);
    if (cachedData != null) {
      final List<dynamic> moviesJson = jsonDecode(cachedData);
      return moviesJson.map((json) => Movie.fromJson(json)).toList();
    }

    final movies =
        await _fetchMovies('$_baseUrl/top_rated?language=en-US&page=$page');
    _cacheBox.put(cacheKey, jsonEncode(movies));
    return movies;
  }

  Future<List<Movie>> getNowPlayingMovies({int page = 1}) async {
    final cacheKey = 'nowPlayingMovies_page_$page';
    final cachedData = _cacheBox.get(cacheKey);
    if (cachedData != null) {
      final List<dynamic> moviesJson = jsonDecode(cachedData);
      return moviesJson.map((json) => Movie.fromJson(json)).toList();
    }

    final movies =
        await _fetchMovies('$_baseUrl/now_playing?language=en-US&page=$page');
    _cacheBox.put(cacheKey, jsonEncode(movies));
    return movies;
  }

  String getFullImageUrl(String imagePath, {String size = 'w500'}) {
    if (imagePath == '') throw "no image path";

    if (!_posterSizes.contains(size)) {
      throw 'Invalid Image Size - $size';
    }

    return '$_secureBaseUrl$size$imagePath';
  }
}
