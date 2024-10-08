import 'package:go_router/go_router.dart';
import 'package:infinity_cinema/src/dominio/entities/movie.dart';
import 'package:infinity_cinema/src/presentation/delegates/search_movie_delegate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:infinity_cinema/src/providers/providers.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.titleLarge;

    return SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: double.infinity,
            child: Row(children: [
              Icon(Icons.movie_creation_outlined, color: colors.primary),
              const SizedBox(width: 10),
              Text('Infinity Cinema', style: textStyle),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    // - provider del repositorio de peliculas -
                    final searchedMovies = ref.read(searchMoviesProvider);
                    // - provider del query search -
                    final searchQuery = ref.read(searchQueryProvider);

                    showSearch<Movie?>(
                            query: searchQuery,
                            context: context,
                            delegate: SearchMovieDelegate(
                                initialMovies: searchedMovies,
                                searchMovies: ref.read(searchMoviesProvider.notifier).searchMoviesByQuery))
                        .then((movie) {
                      if (movie == null) return;

                      context.push('/movie/${movie.id}');
                    });
                  },
                  icon: const Icon(Icons.search))
            ]),
          ),
        ));
  }
}
