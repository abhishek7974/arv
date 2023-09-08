// // To parse this JSON data, do
// //
// //     final topRatedMovies = topRatedMoviesFromJson(jsonString);

// import 'dart:convert';

// import 'package:arv_ssign/Services/Api/ConfigUrl.dart';

// List<TopRatedMovies> topRatedMoviesFromJson(str) => List<TopRatedMovies>.from(str.map((x) => TopRatedMovies.fromJson(x)));

// String topRatedMoviesToJson(List<TopRatedMovies> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class TopRatedMovies {
//   bool? adult;
//   String? backdropPath;
//   List<int>? genreIds;
//   int? id;
//   String? originalLanguage;
//   String? originalTitle;
//   String? overview;
//   double? popularity;
//   String? posterPath;
//   DateTime? releaseDate;
//   String? title;
//   bool? video;
//   double? voteAverage;
//   int? voteCount;

//   TopRatedMovies({
//     this.adult,
//     this.backdropPath,
//     this.genreIds,
//     this.id,
//     this.originalLanguage,
//     this.originalTitle,
//     this.overview,
//     this.popularity,
//     this.posterPath,
//     this.releaseDate,
//     this.title,
//     this.video,
//     this.voteAverage,
//     this.voteCount,
//   });

//   factory TopRatedMovies.fromJson(Map<String, dynamic> json) => TopRatedMovies(
//     adult: json["adult"],
//     backdropPath: json["backdrop_path"],
//     genreIds: json["genre_ids"] == null ? [] : List<int>.from(json["genre_ids"]!.map((x) => x)),
//     id: json["id"],
//     originalLanguage: json["original_language"],
//     originalTitle: json["original_title"],
//     overview: json["overview"],
//     popularity: json["popularity"]?.toDouble(),
//     posterPath: ConfigUrl.imagePath + json["poster_path"],
//     releaseDate: json["release_date"] == null ? null : json['release_date'].substring(0, 4),
//     title: json["title"],
//     video: json["video"],
//     voteAverage: json["vote_average"]?.toDouble(),
//     voteCount: json["vote_count"],
//   );

//   Map<String, dynamic> toJson() => {
//     "adult": adult,
//     "backdrop_path": backdropPath,
//     "genre_ids": genreIds == null ? [] : List<dynamic>.from(genreIds!.map((x) => x)),
//     "id": id,
//     "original_language": originalLanguage,
//     "original_title": originalTitle,
//     "overview": overview,
//     "popularity": popularity,
//     "poster_path": posterPath,
//     "release_date": "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
//     "title": title,
//     "video": video,
//     "vote_average": voteAverage,
//     "vote_count": voteCount,
//   };
// }
