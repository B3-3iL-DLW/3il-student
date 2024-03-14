import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'config.dart';

class ProdConfig extends Config {
  @override
  String get apiUrl => dotenv.env['PROD_API_URL'] ?? 'http://localhost:8000';
}
