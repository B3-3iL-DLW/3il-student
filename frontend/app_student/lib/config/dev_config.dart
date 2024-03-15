import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'config.dart';

class DevConfig extends Config {
  @override
  String get apiUrl => dotenv.env['DEV_API_URL'] ?? 'http://localhost:8000';
}
