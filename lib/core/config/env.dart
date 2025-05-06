import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment variables handler
class Env {
  /// Initializes the environment
  static Future<void> init() async {
    try {
      await dotenv.load(fileName: '.env');
    } catch (e) {
      // If .env file is not found, use default values
      print('Warning: .env file not found, using default values');
    }
  }

  /// Get Supabase URL
  static String get supabaseUrl => 
      dotenv.env['SUPABASE_URL'] ?? 'https://your-supabase-url.supabase.co';

  /// Get Supabase anonymous key
  static String get supabaseAnonKey => 
      dotenv.env['SUPABASE_ANON_KEY'] ?? 'your-supabase-anon-key';

  /// Get app name
  static String get appName => 
      dotenv.env['APP_NAME'] ?? 'Joe Wu Portfolio';

  /// Get app version
  static String get appVersion => 
      dotenv.env['APP_VERSION'] ?? '1.0.0';
} 