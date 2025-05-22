import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String? baseUrl = dotenv.env['HOST'];
  static String? baseUrlImage = dotenv.env['URL'];

  static String loginEndpoint = '$baseUrl/login';
  static String registerEndpoint = '$baseUrl/register';
}
