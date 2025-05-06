import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment variables handler
class Env {
  static bool _initialized = false;
  
  /// Default values
  static const String _defaultSupabaseUrl = 'https://your-supabase-url.supabase.co';
  static const String _defaultSupabaseAnonKey = 'your-supabase-anon-key';
  static const String _defaultAppName = 'Joe Wu Portfolio';
  static const String _defaultAppVersion = '1.0.0';
  
  /// Initializes the environment
  static Future<void> init() async {
    if (_initialized) return;
    
    try {
      await dotenv.load(fileName: '.env');
    } catch (e) {
      // If .env file is not found, use default values
      print('Warning: .env file not found, using default values');
    }
    
    _initialized = true;
  }

  /// Get Supabase URL
  static String get supabaseUrl {
    try {
      return dotenv.env['SUPABASE_URL'] ?? _defaultSupabaseUrl;
    } catch (e) {
      return _defaultSupabaseUrl;
    }
  }

  /// Get Supabase anonymous key
  static String get supabaseAnonKey {
    try {
      return dotenv.env['SUPABASE_ANON_KEY'] ?? _defaultSupabaseAnonKey;
    } catch (e) {
      return _defaultSupabaseAnonKey;
    }
  }

  /// Get app name
  static String get appName {
    try {
      return dotenv.env['APP_NAME'] ?? _defaultAppName;
    } catch (e) {
      return _defaultAppName;
    }
  }

  /// Get app version
  static String get appVersion {
    try {
      return dotenv.env['APP_VERSION'] ?? _defaultAppVersion;
    } catch (e) {
      return _defaultAppVersion;
    }
  }
} 