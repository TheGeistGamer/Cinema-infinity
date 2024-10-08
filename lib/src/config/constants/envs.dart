import 'package:flutter_dotenv/flutter_dotenv.dart';

class Envs {
  static String movieDB = dotenv.env['MOVIE_API_KEY'] ?? '';
}
