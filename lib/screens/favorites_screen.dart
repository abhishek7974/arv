import 'package:arv_ssign/Services/Api/ConfigUrl.dart';
import 'package:arv_ssign/viewModel/HomeModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<HomeModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Movies'),
      ),
      body: ListView.builder(
        itemCount: movieProvider.favoriteMovies.length,
        itemBuilder: (BuildContext context, int index) {
          final movie = movieProvider.favoriteMovies[index];
          final isFavorite =
          movieProvider.favoriteMovies.contains(movie);
          return ListTile(
            contentPadding: EdgeInsets.all(8.0),
            leading: Image.network("${ConfigUrl.imagePath + (movie.posterPath ?? "")}",
                errorBuilder: (context, error, stackTrace) {
                  return Container(); // Return an empty container on image load error
                }),
            title: Text(movie.title ?? ""),
            subtitle: Text('${movie.releaseDate.toString().substring(0, 4)} | IMDB: ${movie.voteAverage.toString().substring(0, 3)}'),
            trailing: IconButton(
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                if (isFavorite) {
                  movieProvider.removeFromFavorites(movie);
                } else {
                  movieProvider.addToFavorites(movie);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
