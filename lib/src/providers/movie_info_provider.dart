import 'package:infinity_cinema/src/dominio/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinity_cinema/src/providers/providers.dart';

typedef GetMovieCallback = Future<Movie> Function(String movieId);

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final movieRepository = ref.watch(movieRespositoryProvider);

  return MovieMapNotifier(movieRepository.getMovieById);
});

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovie;

  MovieMapNotifier(this.getMovie) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;

    final movie = await getMovie(movieId);

    state = {...state, movieId: movie};
  }
}
