import 'package:infinity_cinema/src/config/network/dio.dart';
import 'package:infinity_cinema/src/dominio/datasources/actors_datasource.dart';
import 'package:infinity_cinema/src/dominio/entities/actor.dart';
import 'package:infinity_cinema/src/infrastructure/mappers/actor_mapper.dart';
import 'package:infinity_cinema/src/infrastructure/models/movieDB/credits_response.dart';

class ActorsDBDatasource extends ActorsDatasource {
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');

    final castResponse = CastResponse.fromJson(response.data);

    List<Actor> actors = castResponse.cast
        .map((cast) => ActorMapper.castToEntity(cast))
        .toList();

    return actors;
  }
}
