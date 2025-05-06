import 'package:flutter/material.dart';

/// 項目類別枚舉
enum ProjectCategory {
  mobile,
  web,
  ai,
  openSource,
}

/// 項目模型類
class ProjectModel {
  final String id;
  final String title;
  final String description;
  final String? thumbnail;
  final String? detailedDescription;
  final List<String> technologies;
  final List<ProjectCategory> categories;
  final String? clientName;
  final String? projectLink;
  final String? sourceCodeLink;
  final int year;
  final List<String>? screenshots;
  final Map<String, String>? achievements;
  final List<String>? challenges;
  final List<String>? solutions;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    this.thumbnail,
    this.detailedDescription,
    required this.technologies,
    required this.categories,
    this.clientName,
    this.projectLink,
    this.sourceCodeLink,
    required this.year,
    this.screenshots,
    this.achievements,
    this.challenges,
    this.solutions,
  });
  
  /// 獲取類別名稱
  static String getCategoryName(ProjectCategory category) {
    switch (category) {
      case ProjectCategory.mobile:
        return 'Mobile';
      case ProjectCategory.web:
        return 'Web';
      case ProjectCategory.ai:
        return 'AI/LLM';
      case ProjectCategory.openSource:
        return 'Open Source';
    }
  }
  
  /// 獲取類別顏色
  static Color getCategoryColor(ProjectCategory category, BuildContext context) {
    final theme = Theme.of(context);
    
    switch (category) {
      case ProjectCategory.mobile:
        return theme.colorScheme.primary;
      case ProjectCategory.web:
        return theme.colorScheme.secondary;
      case ProjectCategory.ai:
        return Colors.purple;
      case ProjectCategory.openSource:
        return Colors.green;
    }
  }
  
  /// 獲取類別圖標
  static IconData getCategoryIcon(ProjectCategory category) {
    switch (category) {
      case ProjectCategory.mobile:
        return Icons.smartphone;
      case ProjectCategory.web:
        return Icons.web;
      case ProjectCategory.ai:
        return Icons.psychology;
      case ProjectCategory.openSource:
        return Icons.code;
    }
  }
  
  /// 測試項目數據
  static List<ProjectModel> getSampleProjects() {
    return [
      ProjectModel(
        id: '1',
        title: 'E-Commerce Mobile App',
        description: 'A full-featured e-commerce mobile application built with Flutter for both Android and iOS platforms.',
        technologies: ['Flutter', 'Firebase', 'Bloc', 'Stripe'],
        categories: [ProjectCategory.mobile],
        year: 2023,
        clientName: 'RetailTech Inc.',
        detailedDescription: 'This e-commerce application was developed to provide a seamless shopping experience across multiple devices. It features product browsing, user authentication, cart management, payment processing, and order tracking.',
        thumbnail: 'assets/images/project1.jpg',
        achievements: {
          'downloads': '50,000+',
          'rating': '4.8/5.0',
          'conversion': '12% increase',
        },
        challenges: [
          'Implementing real-time inventory updates across devices',
          'Optimizing performance for low-end devices',
          'Secure payment processing integration',
        ],
        solutions: [
          'Used Firebase Realtime Database for instant inventory updates',
          'Applied advanced caching strategies and lazy loading of images',
          'Implemented PCI-compliant payment processing with Stripe SDK',
        ],
      ),
      ProjectModel(
        id: '2',
        title: 'AI-Powered Health Assistant',
        description: 'An intelligent health assistant that uses natural language processing to provide personalized health recommendations.',
        technologies: ['Flutter', 'TensorFlow Lite', 'DialogFlow', 'Firebase ML'],
        categories: [ProjectCategory.mobile, ProjectCategory.ai],
        year: 2022,
        clientName: 'HealthTech Solutions',
        detailedDescription: 'This application uses artificial intelligence to help users manage their health. It can analyze user inputs, track health metrics, and provide personalized recommendations based on health goals and medical history.',
        thumbnail: 'assets/images/project2.jpg',
        achievements: {
          'accuracy': '92% recommendation accuracy',
          'engagement': '10 min avg. daily usage',
          'retention': '68% 30-day retention',
        },
      ),
      ProjectModel(
        id: '3',
        title: 'Portfolio Website Framework',
        description: 'An open-source framework for building beautiful, responsive portfolio websites using Flutter Web.',
        technologies: ['Flutter Web', 'Responsive Design', 'GitHub Actions', 'Firebase Hosting'],
        categories: [ProjectCategory.web, ProjectCategory.openSource],
        year: 2023,
        sourceCodeLink: 'https://github.com/joewu/portfolio-framework',
        projectLink: 'https://portfolio-framework.web.app',
        detailedDescription: 'This framework was created to help developers easily build and deploy professional portfolio websites using Flutter Web. It includes customizable templates, responsive layouts, and easy deployment options.',
        thumbnail: 'assets/images/project3.jpg',
        achievements: {
          'stars': '1.2k+ GitHub stars',
          'forks': '350+ forks',
          'contributors': '25+ contributors',
        },
      ),
      ProjectModel(
        id: '4',
        title: 'Real Estate Analytics Dashboard',
        description: 'A comprehensive analytics dashboard for real estate professionals to track market trends and property performance.',
        technologies: ['Flutter Web', 'GraphQL', 'Chart.js', 'Google Maps API'],
        categories: [ProjectCategory.web],
        year: 2022,
        clientName: 'PropTech Innovations',
        detailedDescription: 'This web application provides real estate professionals with powerful analytics tools to track market trends, property performance, and client interactions. It features interactive charts, maps, and customizable reports.',
        thumbnail: 'assets/images/project4.jpg',
        achievements: {
          'users': '5,000+ active users',
          'data': '1M+ properties analyzed',
          'efficiency': '35% reduction in analysis time',
        },
      ),
      ProjectModel(
        id: '5',
        title: 'Smart Home Control System',
        description: 'A mobile application that integrates with various smart home devices to provide centralized control and automation.',
        technologies: ['Flutter', 'IoT', 'MQTT', 'BLE', 'Cloud Functions'],
        categories: [ProjectCategory.mobile, ProjectCategory.ai],
        year: 2021,
        clientName: 'HomeConnect Technologies',
        detailedDescription: 'This system allows users to control and automate their smart home devices from a single application. It supports various protocols and can learn user preferences to suggest automated routines.',
        thumbnail: 'assets/images/project5.jpg',
        achievements: {
          'devices': '2,000+ supported devices',
          'automation': '40% increase in home automation',
          'energy': '25% energy savings reported',
        },
      ),
      ProjectModel(
        id: '6',
        title: 'Flutter Data Visualization Library',
        description: 'An open-source library for creating beautiful and interactive data visualizations in Flutter applications.',
        technologies: ['Flutter', 'Canvas API', 'Animations', 'Gesture Recognition'],
        categories: [ProjectCategory.openSource],
        year: 2022,
        sourceCodeLink: 'https://github.com/joewu/flutter-viz',
        detailedDescription: 'This library provides developers with tools to create beautiful, animated, and interactive data visualizations in Flutter applications. It includes chart types like bar, line, pie, scatter, and custom visualizations.',
        thumbnail: 'assets/images/project6.jpg',
        achievements: {
          'pub.dev': '4.9/5 rating on pub.dev',
          'usage': '1,000+ applications using it',
          'performance': '60fps animations on most devices',
        },
      ),
    ];
  }
} 