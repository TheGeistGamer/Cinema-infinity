import 'package:infinity_cinema/src/dominio/entities/movie.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'dart:async';

typedef SerachMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SerachMoviesCallback searchMovies;
  List<Movie> initialMovies;

  // - contructor -
  SearchMovieDelegate(
      {required this.searchMovies, required this.initialMovies});

  // - stream de datos -
  StreamController<List<Movie>> debouncedMovie = StreamController.broadcast();
  StreamController<bool> isLoading = StreamController.broadcast();

  // - timer -
  Timer? _debounceTimer;

  void _onQueryChanged(String query) {
    if (this._debounceTimer?.isActive ?? false) this._debounceTimer!.cancel();

    // Is Loading
    this.isLoading.add(true);

    this._debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      // Bucar películas y emitir al Stream
      final movies = await this.searchMovies(query);
      this.initialMovies = movies;
      this.debouncedMovie.add(movies);
      this.isLoading.add(false);
    });
  }

  // - accion al cerrar el componente -
  void clearStreams() {
    this.debouncedMovie.close();
  }

  // - componente donde se contruye el stream de datos -
  StreamBuilder<List<Movie>> buildCustomStream() {
    return StreamBuilder(
        stream: this.debouncedMovie.stream,
        initialData: this.initialMovies,
        builder: (context, snapshot) {
          final movies = snapshot.data ?? [];

          return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) => _MovieItem(
                  movie: movies[index],
                  onMovieSelected: (context, movie) {
                    this.clearStreams();
                    close(context, movie);
                  }));
        });
  }

  @override
  String get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: this.isLoading.stream, 
        builder: (context, snapshot) {
          final isLoading = snapshot.data ?? false;

          return isLoading
              ? SpinPerfect(
                  duration: const Duration(seconds: 20),
                  spins: 10,
                  infinite: true,
                  child: IconButton(
                    icon: const Icon(Icons.refresh_rounded),
                    onPressed: () {},
                  ))
              : IconButton(
                  onPressed: () => this.query = '',
                  icon: const Icon(Icons.clear));
        }
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          this.clearStreams();

          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    return this.buildCustomStream();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    this._onQueryChanged(query);

    return this.buildCustomStream();
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => this.onMovieSelected(context, this.movie),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            // image
            SizedBox(
                width: size.width * 0.2,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      movie.posterPath,
                      loadingBuilder: (context, child, loadingProgress) =>
                          FadeIn(child: child),
                    ))),

            const SizedBox(width: 10),

            // descripcion
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyle.titleMedium),
                  (movie.overview.length > 100)
                      ? Text('${movie.overview.substring(0, 100)}...',
                          style: textStyle.bodyMedium)
                      : Text(movie.overview, style: textStyle.bodyMedium),

                  // rating
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded,
                          color: Colors.yellow.shade800),
                      const SizedBox(width: 5),
                      Text(movie.voteAverage.toString(),
                          style: textStyle.bodyMedium!.copyWith(
                              color: Colors.yellow.shade800,
                              fontWeight: FontWeight.bold))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
