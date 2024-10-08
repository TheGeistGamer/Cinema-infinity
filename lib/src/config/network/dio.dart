import 'package:infinity_cinema/src/config/constants/envs.dart';
import 'package:dio/dio.dart';

final dio =
    Dio(BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
  'api_key': Envs.movieDB,
  'language': 'es-MX',
}));
