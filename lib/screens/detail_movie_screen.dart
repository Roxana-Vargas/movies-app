import 'package:flutter/material.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/providers/movies_provider.dart';
import 'package:movies/widgets/widgets.dart';
import 'package:provider/provider.dart';

class DetailMovie extends StatelessWidget {
  const DetailMovie({super.key});

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie: movie),
          SliverList(
              delegate: SliverChildListDelegate([
            _PosterAndTitle(movie: movie),
            _Overview(movie: movie),
            const SizedBox(height: 10.0),
            CastingCards(
              movieId: movie.id,
            )
          ]))
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomAppBar({super.key, required this.movie});
  // const _CustomAppBar({required this.movie});
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.all(0),
        centerTitle: true,
        title: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 10),
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: Text(movie.title, style: const TextStyle(fontSize: 16)),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/back.png'),
          image: NetworkImage(movie.fullBackdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Movie movie;

  const _PosterAndTitle({super.key, required this.movie});
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                height: 150,
                placeholder: const AssetImage('assets/back.png'),
                image: NetworkImage(movie.fullPosterPath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title,
                    style: textTheme.headline5,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2),
                Text(movie.originalTitle,
                    style: textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2),
                Row(
                  children: [
                    const Icon(
                      Icons.star_outline,
                      size: 15,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 5),
                    Text(movie.popularity.toString(), style: textTheme.caption)
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Movie movie;

  const _Overview({super.key, required this.movie});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
