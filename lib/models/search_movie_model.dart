import 'dart:convert';

import 'package:movies/models/movie_model.dart';

SearchMovie searchMovieFromJson(String str) =>
    SearchMovie.fromJson(json.decode(str));

class SearchMovie {
  SearchMovie({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  factory SearchMovie.fromJson(Map<String, dynamic> json) => SearchMovie(
        page: json["page"],
        results:
            List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
