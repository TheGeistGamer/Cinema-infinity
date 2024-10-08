import 'package:infinity_cinema/src/infrastructure/models/movieDB/moviedb_response.dart';
import 'package:infinity_cinema/src/infrastructure/models/movieDB/movie_details.dart';
import 'package:infinity_cinema/src/dominio/datasources/movies_datasource.dart';
import 'package:infinity_cinema/src/infrastructure/mappers/movie_mapper.dart';
import 'package:infinity_cinema/src/dominio/entities/movie.dart';
import 'package:infinity_cinema/src/config/network/dio.dart';

class MovieDBDataSource extends MoviesDataSource {
  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDBReponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDBReponse.results
        .where((moviedb) => moviedb.posterPath != 'Poster no disponible ')
        .map((movie) => MovieMapper.movieDBToEntity(movie))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlayingMovies({int page = 1}) async {
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response =
        await dio.get('/movie/popular', queryParameters: {'page': page});

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response =
        await dio.get('/movie/top_rated', queryParameters: {'page': page});

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response =
        await dio.get('/movie/upcoming', queryParameters: {'page': page});

    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200) {
      throw Exception('Error al obtener la película');
    }

    final movieDB = MovieDetails.fromJson(response.data);

    final Movie movie = MovieMapper.movieDetailsToEntity(movieDB);

    return movie;
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];

    final response =
        await dio.get('/search/movie', queryParameters: {'query': query});

    return _jsonToMovies(response.data);
  }
}
