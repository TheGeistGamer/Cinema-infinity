import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinity_cinema/src/dominio/entities/movie.dart';
import 'package:infinity_cinema/src/providers/movies_repository_provider.dart';

// -- guarda el query del search --
final searchQueryProvider = StateProvider<String>((ref) => '');

final searchMoviesProvider = StateNotifierProvider<SearchMoviesNotifier, List<Movie>>((ref) {
  final movieRepository = ref.read(movieRespositoryProvider);

  return SearchMoviesNotifier(
      ref: ref, searchMovies: movieRepository.searchMovies);
});

// - solo declara el tipo de la funcion de busqueda de peliculas -
typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMoviesNotifier extends StateNotifier<List<Movie>> {
  final SearchMoviesCallback searchMovies;
  final Ref ref;

  SearchMoviesNotifier({required this.searchMovies, required this.ref}): super([]);

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    // - hacer la solicitud de busqueda de peliculas -
    final List<Movie> movies = await this.searchMovies(query);

    // - guardar el "query" en el state -
    ref.read(searchQueryProvider.notifier).update((state) => query);

    state = movies;
    return movies;
  }
}
