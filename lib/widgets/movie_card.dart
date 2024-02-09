import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myapp/data/api_client/models/movie.dart';
import 'package:myapp/screens/movie/movie.dart';
import 'package:myapp/utils/utils.dart';
import 'package:myapp/widgets/widgets.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.movie,
  });
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => toScreen(context, MovieScreen(movie: movie)),
      child: SizedBox(
        width: AppDimensions.vw(context, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: movie.imageUrl,
              child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: movie.imageUrl,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                    height: 200,
                  )),
            ),
            Hero(
                tag: movie.title,
                child: Material(
                    type: MaterialType.transparency,
                    child: AppText.small(movie.title, size: size * 2.4))),
            AppText.small(
              movie.datetime.string,
              size: size * 1.5,
              weight: FontWeight.w600,
              color: Theme.of(context).shadowColor.withOpacity(.8),
            ),
          ],
        ),
      ),
    );
  }
}

// Image.network(
//                 imageUrl,
//                 width: double.maxFinite,
//                 fit: BoxFit.cover,
//                 height: 200,
//               )