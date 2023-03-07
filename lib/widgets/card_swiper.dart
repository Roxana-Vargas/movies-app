import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movies/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;
  const CardSwiper({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: double.infinity,
      height: deviceHeight * 0.5,
      child: Swiper(
          itemCount: movies.length,
          layout: SwiperLayout.STACK,
          itemWidth: deviceWidth * 0.6,
          itemHeight: deviceHeight * 0.4,
          itemBuilder: (_, index) {
            final movie = movies[index];
            movie.heroId = 'swiper-${movie.id}';
            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/detailMovie',
                  arguments: movie),
              child: Hero(
                tag: movie.heroId!,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: const AssetImage('assets/back.png'),
                    image: NetworkImage(movie.fullPosterPath),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
