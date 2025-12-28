import 'dart:developer' as dev;
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Environment { dev, prod, staging }

class AppConfig {
  static const String _tag = 'CONFIG';
  static late final Environment environment;

  static String get apiBaseUrl => _get('API_BASE_URL');
  static Map<String, String> get _allEnv => dotenv.env;

  static String _get(String key) {
    final value = _allEnv[key];
    if (value == null) {
      dev.log('❌ Error: $key not found in .env', name: _tag);
      throw Exception('Env variable $key not found');
    }
    return value;
  }

  static Future<void> load() async {
    const envString = String.fromEnvironment('ENV', defaultValue: 'dev');
    const emoji = envString == 'prod' ? '🔥' : '🐛';
    dev.log('$emoji Loading config: $envString', name: _tag);

    environment = Environment.values.firstWhere(
      (e) => e.name == envString,
      orElse: () => Environment.dev,
    );

    const fileName = '.env.$envString';

    try {
      await dotenv.load(fileName: fileName);
      dev.log('✅ Loaded: $fileName', name: _tag);
    } on Exception catch (_) {
      dev.log('⚠️ $fileName not found, loading .env', name: _tag);
      await dotenv.load();
    }

    dev.log('🌐 API Base URL: $apiBaseUrl', name: _tag);
  }
}
