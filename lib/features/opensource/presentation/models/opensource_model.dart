import 'package:flutter/material.dart';

/// 開源項目類型枚舉
enum OpenSourceType {
  repository,
  contribution,
  community,
}

/// 開源項目模型類
class OpenSourceModel {
  final String name;
  final String description;
  final String? organization;
  final OpenSourceType type;
  final int stars;
  final int forks;
  final int issues;
  final int pullRequests;
  final String? language;
  final Color? languageColor;
  final String? repoUrl;
  final List<String>? topics;
  final DateTime lastUpdated;
  
  const OpenSourceModel({
    required this.name,
    required this.description,
    this.organization,
    required this.type,
    required this.stars,
    required this.forks,
    required this.issues,
    required this.pullRequests,
    this.language,
    this.languageColor,
    this.repoUrl,
    this.topics,
    required this.lastUpdated,
  });
  
  /// 獲取類型名稱
  String getTypeName() {
    switch (type) {
      case OpenSourceType.repository:
        return 'Repository';
      case OpenSourceType.contribution:
        return 'Contribution';
      case OpenSourceType.community:
        return 'Community';
    }
  }
  
  /// 獲取類型圖標
  IconData getTypeIcon() {
    switch (type) {
      case OpenSourceType.repository:
        return Icons.folder;
      case OpenSourceType.contribution:
        return Icons.code;
      case OpenSourceType.community:
        return Icons.people;
    }
  }
  
  /// 示例開源項目數據
  static List<OpenSourceModel> getSampleProjects() {
    return [
      // 倉庫
      OpenSourceModel(
        name: 'flutter_viz',
        description: 'A comprehensive data visualization library for Flutter applications, providing customizable and animated charts, graphs, and interactive visualizations.',
        organization: 'joewu',
        type: OpenSourceType.repository,
        stars: 1250,
        forks: 320,
        issues: 25,
        pullRequests: 15,
        language: 'Dart',
        languageColor: Colors.blue,
        repoUrl: 'https://github.com/joewu/flutter_viz',
        topics: ['flutter', 'data-visualization', 'charts', 'graphs', 'animations'],
        lastUpdated: DateTime(2023, 8, 15),
      ),
      OpenSourceModel(
        name: 'flutter_state_plus',
        description: 'An extended state management solution for Flutter that combines the best aspects of different approaches with performance optimizations.',
        organization: 'joewu',
        type: OpenSourceType.repository,
        stars: 850,
        forks: 220,
        issues: 12,
        pullRequests: 8,
        language: 'Dart',
        languageColor: Colors.blue,
        repoUrl: 'https://github.com/joewu/flutter_state_plus',
        topics: ['flutter', 'state-management', 'reactive', 'performance'],
        lastUpdated: DateTime(2023, 10, 5),
      ),
      OpenSourceModel(
        name: 'mobile_health_ai',
        description: 'An open-source framework for integrating AI-powered health analysis and recommendations into mobile applications, with privacy-first design.',
        organization: 'health-tech-collective',
        type: OpenSourceType.repository,
        stars: 620,
        forks: 180,
        issues: 35,
        pullRequests: 22,
        language: 'Dart',
        languageColor: Colors.blue,
        repoUrl: 'https://github.com/health-tech-collective/mobile_health_ai',
        topics: ['flutter', 'healthcare', 'ai', 'machine-learning', 'privacy'],
        lastUpdated: DateTime(2023, 9, 12),
      ),
      OpenSourceModel(
        name: 'flutter_accessibility_tools',
        description: 'A toolkit for improving accessibility in Flutter applications, including automated checks, adaptive widgets, and best practice implementations.',
        organization: 'joewu',
        type: OpenSourceType.repository,
        stars: 430,
        forks: 110,
        issues: 18,
        pullRequests: 14,
        language: 'Dart',
        languageColor: Colors.blue,
        repoUrl: 'https://github.com/joewu/flutter_accessibility_tools',
        topics: ['flutter', 'accessibility', 'a11y', 'wcag', 'inclusive-design'],
        lastUpdated: DateTime(2023, 7, 28),
      ),
      
      // 貢獻
      OpenSourceModel(
        name: 'flutter',
        description: 'Contributed multiple performance improvements and bug fixes to the Flutter framework, particularly in the areas of animations and accessibility.',
        organization: 'flutter',
        type: OpenSourceType.contribution,
        stars: 156000,
        forks: 25800,
        issues: 12500,
        pullRequests: 280,
        language: 'Dart',
        languageColor: Colors.blue,
        repoUrl: 'https://github.com/flutter/flutter',
        topics: ['flutter', 'framework', 'cross-platform', 'ui-toolkit'],
        lastUpdated: DateTime(2023, 11, 2),
      ),
      OpenSourceModel(
        name: 'tensorflow',
        description: 'Contributed optimizations to TensorFlow Lite for mobile platforms, enhancing performance for on-device machine learning in Flutter applications.',
        organization: 'tensorflow',
        type: OpenSourceType.contribution,
        stars: 178000,
        forks: 89000,
        issues: 3600,
        pullRequests: 450,
        language: 'C++',
        languageColor: Colors.red,
        repoUrl: 'https://github.com/tensorflow/tensorflow',
        topics: ['machine-learning', 'deep-learning', 'neural-networks', 'ai'],
        lastUpdated: DateTime(2023, 6, 18),
      ),
      OpenSourceModel(
        name: 'firebase-flutter',
        description: 'Contributed to improving the integration between Firebase services and Flutter, including auth flows and Firestore performance optimizations.',
        organization: 'firebase',
        type: OpenSourceType.contribution,
        stars: 6200,
        forks: 1800,
        issues: 410,
        pullRequests: 85,
        language: 'Dart',
        languageColor: Colors.blue,
        repoUrl: 'https://github.com/firebase/flutterfire',
        topics: ['flutter', 'firebase', 'cloud', 'authentication', 'database'],
        lastUpdated: DateTime(2023, 9, 5),
      ),
      
      // 社群
      OpenSourceModel(
        name: 'Flutter Forward Conference',
        description: 'Organized and spoke at the Flutter Forward community conference, bringing together developers to share knowledge and best practices.',
        organization: 'flutter-community',
        type: OpenSourceType.community,
        stars: 0,
        forks: 0,
        issues: 0,
        pullRequests: 0,
        repoUrl: 'https://flutter-forward.com',
        lastUpdated: DateTime(2023, 6, 12),
      ),
      OpenSourceModel(
        name: 'Flutter Mentorship Program',
        description: 'Led a mentorship program helping early-career developers learn Flutter development through structured guidance and real-world projects.',
        organization: 'flutter-community',
        type: OpenSourceType.community,
        stars: 0,
        forks: 0,
        issues: 0,
        pullRequests: 0,
        lastUpdated: DateTime(2023, 4, 20),
      ),
      OpenSourceModel(
        name: 'Flutter Documentation Translation',
        description: 'Coordinated efforts to translate Flutter documentation into multiple languages, improving accessibility for non-English speaking developers.',
        organization: 'flutter-i18n',
        type: OpenSourceType.community,
        stars: 0,
        forks: 0,
        issues: 0,
        pullRequests: 0,
        repoUrl: 'https://github.com/flutter-i18n/flutter-docs-translation',
        lastUpdated: DateTime(2023, 8, 30),
      ),
    ];
  }
  
  /// 獲取按類型分組的開源項目
  static Map<OpenSourceType, List<OpenSourceModel>> getProjectsByType() {
    final projects = getSampleProjects();
    final map = <OpenSourceType, List<OpenSourceModel>>{};
    
    for (final type in OpenSourceType.values) {
      map[type] = projects.where((project) => project.type == type).toList();
    }
    
    return map;
  }
} 