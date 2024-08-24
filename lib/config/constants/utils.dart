import 'package:flutter_dotenv/flutter_dotenv.dart';

class Utils {
  String apiUrl = dotenv.env['API_BASE'] ?? "";
  String apiKey = dotenv.env['API_KEY'] ?? "";
}
