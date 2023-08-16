import 'dart:convert';

import 'package:arv_ssign/Services/Api/Api.dart';
import 'package:arv_ssign/Services/Api/ConfigUrl.dart';
import 'package:arv_ssign/models/top_rated.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class HomeModel extends ChangeNotifier {

  List<TopRatedMovies> _movies = [];
  List<TopRatedMovies> _favoriteMovies = [];
  List<TopRatedMovies> _searchMoviesList = [];


  TextEditingController _searchController = TextEditingController();

  String _sortBy = 'release_date.desc';
  int page = 1;
  bool isLoading = false;

  List<TopRatedMovies> get movies => _movies;
  List<TopRatedMovies> get favoriteMovies => _favoriteMovies;
  List<TopRatedMovies> get searchMoviesList => _searchMoviesList;


  String get sortBy => _sortBy;

  bool _isSearchVisible = false;

  bool get isSearchVisible => _isSearchVisible;

  Future<void> fetchTopRatedMovies(BuildContext context) async {

    final result = await DioApi.get(path: '${ConfigUrl.topRated}&page=$page&sort_by=$_sortBy');

    if (result.response != null) {
      final data = result.response?.data;
      // final List<dynamic> moviList = data['results'];
      List<dynamic> filteredList =  data['results'];

      if(_sortBy == sortByDate){

        filteredList.sort((a, b) => b["release_date"].compareTo(a["release_date"]));
      }if(_sortBy == sortByPopularity){

        filteredList.sort((a, b) => b["popularity"].compareTo(a["popularity"]));
      }if(_sortBy == sortByVotingAvg){

        filteredList.sort((a, b) => b["vote_average"].compareTo(a["vote_average"]));
      }

      final List<TopRatedMovies> newMovies =  topRatedMoviesFromJson(filteredList);
      
      if(_movies.length != 0){
        final tempMovies = _movies.addAll(newMovies);
        isLoading = false;
        if(_sortBy == sortByDate){
          print(_sortBy);
          _movies.sort((a, b) => b.releaseDate.toString().compareTo(a.releaseDate.toString()));
        }if(_sortBy == sortByPopularity){
          print(_sortBy);
          _movies.sort((a, b) => b.popularity.toString().compareTo(a.popularity.toString()));
        }if(_sortBy == sortByVotingAvg){
          print(_sortBy);
          _movies.sort((a, b) => b.voteAverage.toString().compareTo(a.voteAverage.toString()));
        }
        isLoading = true;
      }  else {
        _movies.addAll(newMovies);
      }

      isLoading = false;
      page++;
      notifyListeners();
    } else {
      result.handleError(context);
    }
  }


  Future<void> searchTopRatedMovies(BuildContext context,String query) async {

    final result = await DioApi.get(path: '${ConfigUrl.moviesApi}&query=$query&page=$page');

    if (result.response != null) {
      final data = result.response?.data;
      List<dynamic> filteredList =  data['results'];
      final List<TopRatedMovies> newMovies =  topRatedMoviesFromJson(filteredList);
      _searchMoviesList = newMovies;
      notifyListeners();
    } else {
      result.handleError(context);
    }
  }

   void setPage(int pageIdx){
     page =  pageIdx;
     notifyListeners();
   }

   void searchMovie(String searchTerm){
   _searchMoviesList = _movies.where((movie) {
       String title = movie.title ?? "";
       return title.toLowerCase().contains(searchTerm.toLowerCase());
     }).toList();
   notifyListeners();
   }


  fetchMovies(BuildContext context, {String searchQuery = ''}) {}

  void setSortBy(String sortBy, BuildContext context) {
    _sortBy = sortBy;
    _movies.clear();
    fetchTopRatedMovies(context);
    notifyListeners();
  }

  void setSearchQuery(String query, BuildContext context) {
    _movies.clear();

    fetchMovies(context, searchQuery: query);
  }

  void addToFavorites(TopRatedMovies topRated) {
    _favoriteMovies.add(topRated);
    notifyListeners();
  }

  void removeFromFavorites(TopRatedMovies movie) {
    print("removing data");
     _favoriteMovies.removeWhere((element) => element.id == movie.id);
    notifyListeners();
  }

  void dispose() {
    _searchController.dispose();
  }

  void toggleSearch() {
    _isSearchVisible = !_isSearchVisible;
    notifyListeners();
  }
}
