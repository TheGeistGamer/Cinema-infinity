import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:infinity_cinema/src/dominio/entities/movie.dart';
import 'package:infinity_cinema/src/providers/movie_info_provider.dart';
import 'package:infinity_cinema/src/providers/providers.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const String name = 'movie-screen';
  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  createState() => _MovieScreenState();
}

class _MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator(strokeWidth: 2)));
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliver(movie),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => _MovieDetails(movie: movie),
                  childCount: 1))
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child:
                      Image.network(movie.posterPath, width: size.width * 0.3),
                ),

                const SizedBox(width: 10),

                // Descripcion
                SizedBox(
                    width: (size.width - 40) * 0.7,
                    child: Column(
                      children: [
                        Text(movie.title, style: textStyle.titleLarge),
                        Text(movie.overview)
                      ],
                    ))
              ],
            )),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map((gender) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Chip(
                      label: Text(gender),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ))
            ],
          ),
        ),
        _ActorsByMovie(movieId: movie.id),
      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final int movieId;
  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);
    if (actorsByMovie[movieId.toString()] == null) {
      return const CircularProgressIndicator(strokeWidth: 2);
    }

    final actors = actorsByMovie[movieId.toString()]!;

    return SizedBox(
      height: 300,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final actor = actors[index];

            return Container(
              padding: const EdgeInsets.all(8),
              width: 135,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Foto
                    FadeInRight(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(actor.profilePath,
                            height: 180, width: 135, fit: BoxFit.cover),
                      ),
                    ),

                    // Nombre
                    const SizedBox(height: 5),

                    Text(actor.name,
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                    Text(
                      actor.character ?? '',
                      maxLines: 2,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    )
                  ]),
            );
          }),
    );
  }
}

class _CustomSliver extends StatelessWidget {
  final Movie movie;
  const _CustomSliver(this.movie);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        // title: Text(movie.title,
        //     textAlign: TextAlign.center,
        //     style: const TextStyle(fontSize: 20, color: Colors.white)),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const DecoratedBox(
                        decoration: BoxDecoration(color: Colors.black12));
                  }

                  return FadeIn(child: child);
                },
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.7, 1.0],
                          colors: [Colors.transparent, Colors.black87]))),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(begin: Alignment.topLeft, stops: [
                0.0,
                0.3
              ], colors: [
                Colors.black87,
                Colors.transparent,
              ]))),
            )
          ],
        ),
      ),
    );
  }
}
