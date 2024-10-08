import 'package:infinity_cinema/src/dominio/entities/actor.dart';
import 'package:infinity_cinema/src/infrastructure/models/movieDB/credits_response.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath != null
          ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
          : 'https://imgs.search.brave.com/9nYtD1y4QldQkoUphOP8ybG0YfW503Z5Te5wXu6nsUY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pY29u/LWxpYnJhcnkuY29t/L2ltYWdlcy9uby1w/cm9maWxlLXBpYy1p/Y29uL25vLXByb2Zp/bGUtcGljLWljb24t/MjcuanBn',
      character: cast.character);
}
