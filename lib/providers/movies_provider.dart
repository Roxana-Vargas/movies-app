import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/helpers/debouncer.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/models/now_playing_model.dart';
import 'package:movies/models/popular_model.dart';
import 'package:movies/models/search_movie_model.dart';

import '../models/credits_model.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apikey = '603d010f363fa7e45f2da973ee89a8d7';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';
  int _numberPage = 0;

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  final debouncer = Debouncer(duration: const Duration(milliseconds: 500));

  final StreamController<List<Movie>> _suggestionStreamController =
      StreamController.broadcast();

  Stream<List<Movie>> get suggestionStream =>
      _suggestionStreamController.stream;

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apikey,
      'language': _language,
      'page': '$page',
    });
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final data = await _getJsonData('/3/movie/now_playing');
    final NowPlayingResponse nowPlayingResponse =
        nowPlayingResponseFromJson(data);
    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getPopularMovies() async {
    _numberPage++;

    final data = await _getJsonData('3/movie/popular', _numberPage);
    final PopularMovies popularMoviesResponse = popularMoviesFromJson(data);
    popularMovies = [...popularMovies, ...popularMoviesResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    final data = await _getJsonData('3/movie/$movieId/credits');
    final Credits creditsResponse = creditsFromJson(data);

    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apikey,
      'language': _language,
      'query': query,
    });
    final response = await http.get(url);
    final searchMovieResponse = searchMovieFromJson(response.body);
    return searchMovieResponse.results;
  }

  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await searchMovie(value);
      _suggestionStreamController.add(results);
    };
    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(const Duration(milliseconds: 301))
        .then((value) => timer.cancel());
  }
}
