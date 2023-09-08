
import 'package:arv_ssign/screens/details_screen.dart';
import 'package:arv_ssign/screens/favorites_screen.dart';
import 'package:arv_ssign/viewModel/HomeModel.dart';
import 'package:arv_ssign/widgets/movie.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _loadMore() async {
    if (_controller.position.extentAfter < 20) {
      inIt();
    }
  }

  late ScrollController _controller;
  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_loadMore);
    inIt();
  }

  inIt() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final homeData = Provider.of<HomeModel>(context,listen: false);
      homeData.fetchTopRatedMovies(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<HomeModel>(context);
    return Scaffold(
        appBar: AppBar(
          leading: movieProvider.isSearchVisible
              ? GestureDetector(
                  onTap: () {
                    movieProvider.toggleSearch();
                    movieProvider.setPage(1);
                  },
                  child: Icon(Icons.arrow_back_ios))
              : null,
          title: movieProvider.isSearchVisible
              ? TextField(
                  onChanged: (query) {
                    movieProvider.searchTopRatedMovies(context, query);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search Movies',
                    border: InputBorder.none,
                  ),
                )
              : Text('Top Rated Movies'),
          actions: [
            IconButton(
              onPressed: () {
                movieProvider.toggleSearch();
                movieProvider.setPage(1);
              },
              icon: Icon(Icons.search),
            ),
            // if (!movieProvider.isSearchVisible)
            //   IconButton(
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => FavoritesPage()),
            //       );
            //     },
            //     icon: Icon(Icons.favorite),
            //   ),
            if (!movieProvider.isSearchVisible)
              PopupMenuButton<String>(
                onSelected: (sortBy) {
                  movieProvider.setPage(1);
                  movieProvider.setSortBy(sortBy, context);
                },
                itemBuilder: (BuildContext context) {
                  return const [
                    PopupMenuItem<String>(
                      value: 'vote_average.desc',
                      child: Text('Sort by IMDB Rating'),
                    ),
                    PopupMenuItem<String>(
                      value: 'popularity.desc',
                      child: Text('Sort by Popularity'),
                    ),
                    PopupMenuItem<String>(
                      value: 'release_date.desc',
                      child: Text('Sort by Year'),
                    ),
                  ];
                },
              ),
          ],
        ),
        body: Column(
          children: [
            Expanded( 
              //asdf
              child: ListView.builder(
                itemCount: movieProvider.isSearchVisible
                    ? movieProvider.searchMoviesList.length
                    : movieProvider.movies.length,
                controller: _controller,
                itemBuilder: (_, index) {
                  if (index < movieProvider.movies.length) {
                    final movie = movieProvider.isSearchVisible
                        ? movieProvider.searchMoviesList[index]
                        : movieProvider.movies[index];
                    final isFavorite =
                        movieProvider.favoriteMovies.contains(movie);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DetailsScreen(movie: movie);
                        }));
                      },
                      child: MovieWidget(
                        movie: movie,
                        isFavorite: isFavorite,
                        movieProvider: movieProvider,
                      ),
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritesPage()));
        },

        backgroundColor: Colors.black,

        child: const Icon(Icons.favorite),
      ),

    );

  }
}
