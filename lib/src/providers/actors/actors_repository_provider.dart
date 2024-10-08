import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinity_cinema/src/infrastructure/datasources/actors_datasource.dart';
import 'package:infinity_cinema/src/infrastructure/repositories/actors_repository_impl.dart';

final actorRepositoryProvider = Provider((ref) {
  return ActorsRepositoryImpl(ActorsDBDatasource());
});
