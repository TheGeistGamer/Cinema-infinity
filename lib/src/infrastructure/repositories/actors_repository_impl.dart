import 'package:infinity_cinema/src/dominio/datasources/actors_datasource.dart';
import 'package:infinity_cinema/src/dominio/repositories/actors_repository.dart';
import 'package:infinity_cinema/src/dominio/entities/actor.dart';

class ActorsRepositoryImpl extends ActorsRepository {
  final ActorsDatasource datasrouce;

  ActorsRepositoryImpl(this.datasrouce);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    return datasrouce.getActorsByMovie(movieId);
  }
}
