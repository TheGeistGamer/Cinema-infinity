import 'package:infinity_cinema/src/infrastructure/datasources/movie_datasource.dart';
import 'package:infinity_cinema/src/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Este repositorio es inmutable
final movieRespositoryProvider =
    Provider((ref) => MovieRepositoryImpl(MovieDBDataSource()));
