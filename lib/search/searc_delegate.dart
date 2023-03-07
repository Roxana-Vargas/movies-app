import 'package:flutter/material.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => 'Buscar pelicula';
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];

    // throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back));
    // throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults

    return Container();
    // throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    if (query.isEmpty) return _emptyContainer();

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionsByQuery(query);

    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();
        final movies = snapshot.data!;
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) =>
              _MovieItem(movie: movies[index]),
        );
      },
    );
    // throw UnimplementedError();
  }

  Widget _emptyContainer() {
    return Container(
      child: Center(
        child: Icon(
          Icons.movie_creation_outlined,
          color: Colors.black12,
          size: 110,
        ),
      ),
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;

  const _MovieItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'search-${movie.id}';
    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          image: NetworkImage(movie.fullPosterPath),
          placeholder: const AssetImage('assets/back.png'),
          width: 50,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () =>
          Navigator.pushNamed(context, '/detailMovie', arguments: movie),
    );
  }
}
