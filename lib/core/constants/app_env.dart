import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Environment { dev, staging, prod }

class AppEnv {
  // Set the current environment here
  static const Environment currentEnv = Environment.dev;

  // File names for each environment
  static const String devEnvFile = '.env';
  static const String stagingEnvFile = '.env.dev';
  static const String prodEnvFile = '.env.prod';

  // Get the correct file name for dotenv
  static String get envFileName {
    switch (currentEnv) {
      case Environment.dev:
        return devEnvFile;
      case Environment.staging:
        return stagingEnvFile;
      case Environment.prod:
        return prodEnvFile;
    }
  }

  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';
  static String get apiKey => dotenv.env['API_KEY'] ?? '';
  static int get apiTimeout => int.tryParse(dotenv.env['API_TIMEOUT'] ?? '30000') ?? 30000;
} 