import 'dart:convert';

import 'package:movies/models/movie_model.dart';

PopularMovies popularMoviesFromJson(String str) =>
    PopularMovies.fromJson(json.decode(str));

class PopularMovies {
  PopularMovies({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  factory PopularMovies.fromJson(Map<String, dynamic> json) => PopularMovies(
        page: json["page"],
        results:
            List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
