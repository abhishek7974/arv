import 'package:arv_ssign/Services/Api/ConfigUrl.dart';
import 'package:arv_ssign/viewModel/HomeModel.dart';
import 'package:flutter/material.dart';

import '../models/top_rated.dart';

class MovieWidget extends StatelessWidget {
  const MovieWidget({
    super.key,
    required this.movie,
    required this.isFavorite,
    required this.movieProvider,
  });

  final TopRatedMovies movie;
  final bool isFavorite;
  final HomeModel movieProvider;

  @override
  Widget build(BuildContext context) {

    return Card(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            height: 120,
              child: Image.network("${ConfigUrl.imagePath + (movie.posterPath ?? "")}",
                  errorBuilder: (context, error, stackTrace) {
            return Container(); // Return an empty container on image load error
            }),
          ),
          Expanded(child: Container(
            padding: EdgeInsets.all(8),
            height: 120,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Expanded(child: Text(movie.title ?? "",style: TextStyle(fontSize: 18,
                         fontWeight: FontWeight.bold),)),
                     IconButton(
                       icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                       onPressed: () {
                         if (isFavorite) {
                           movieProvider.removeFromFavorites(movie);
                         } else {
                           movieProvider.addToFavorites(movie);
                         }
                       },
                     )
                   ],
                 ),
                 Expanded(child: Text(""
                     "${movie.overview}",
                   maxLines: 2,
                 )),
                 Text('${movie.releaseDate.toString().substring(0, 4)} | IMDB: ${movie.voteAverage.toString().substring(0, 3)}',)
               ],
             ),
          ))

        ],
      ),
    );
  }
}