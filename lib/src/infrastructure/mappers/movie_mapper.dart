import 'package:infinity_cinema/src/infrastructure/models/movieDB/movie.model.dart';
import 'package:infinity_cinema/src/dominio/entities/movie.dart';
import 'package:infinity_cinema/src/infrastructure/models/movieDB/movie_details.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieFromMovieDB db) => Movie(
      adult: db.adult,
      backdropPath: (db.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w500${db.backdropPath}'
          : 'https://plus.unsplash.com/premium_photo-1669632824466-09b2c595aa4c?q=80&w=3387&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      genreIds: db.genreIds.map((e) => e.toString()).toList(),
      id: db.id,
      originalLanguage: db.originalLanguage,
      originalTitle: db.originalTitle,
      overview: db.overview,
      popularity: db.popularity,
      posterPath: (db.posterPath != '')
          ? 'https://image.tmdb.org/t/p/w500${db.posterPath}'
          : 'https://ih1.redbubble.net/image.2487419682.3594/cposter,medium,product,750x1000.2.jpg',
      releaseDate: db.releaseDate ?? DateTime.now(),
      title: db.title,
      video: db.video,
      voteAverage: db.voteAverage,
      voteCount: db.voteCount);

  static Movie movieDetailsToEntity(MovieDetails db) => Movie(
      adult: db.adult,
      backdropPath: (db.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w500${db.backdropPath}'
          : 'https://plus.unsplash.com/premium_photo-1669632824466-09b2c595aa4c?q=80&w=3387&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      genreIds: db.genres.map((e) => e.name.toString()).toList(),
      id: db.id,
      originalLanguage: db.originalLanguage,
      originalTitle: db.originalTitle,
      overview: db.overview,
      popularity: db.popularity,
      posterPath: db.posterPath != ''
          ? 'https://image.tmdb.org/t/p/w500${db.posterPath}'
          : 'https://plus.unsplash.com/premium_photo-1669632824466-09b2c595aa4c?q=80&w=3387&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      releaseDate: db.releaseDate,
      title: db.title,
      video: db.video,
      voteAverage: db.voteAverage,
      voteCount: db.voteCount);
}
