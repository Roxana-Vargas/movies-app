import 'package:flutter/material.dart';
import 'package:movies/models/popular_model.dart';
import 'package:movies/providers/movies_provider.dart';
import 'package:movies/search/searc_delegate.dart';
import 'package:movies/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search_outlined,
            ),
            onPressed: (() =>
                showSearch(context: context, delegate: MovieSearchDelegate())),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(movies: moviesProvider.onDisplayMovies),
            MovieSlider(
              movies: moviesProvider.popularMovies,
              title: 'Populares',
              onNextPage: () => moviesProvider.getPopularMovies(),
            ),
          ],
        ),
      ),
    );
  }
}
