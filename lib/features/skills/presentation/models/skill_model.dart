import 'package:flutter/material.dart';

/// 技能類別枚舉
enum SkillCategory {
  language,
  framework,
  mobile,
  web,
  backend,
  devops,
  ai,
  design,
  soft,
}

/// 技能熟練度等級枚舉
enum SkillLevel {
  beginner,
  intermediate,
  advanced,
  expert,
}

/// 技能模型類
class SkillModel {
  final String name;
  final SkillCategory category;
  final SkillLevel level;
  final String? description;
  final String? iconAsset;
  final int yearsOfExperience;
  final List<String>? projects;

  const SkillModel({
    required this.name,
    required this.category,
    required this.level,
    this.description,
    this.iconAsset,
    required this.yearsOfExperience,
    this.projects,
  });
  
  /// 獲取技能等級百分比 (0.0 - 1.0)
  double getLevelPercentage() {
    switch (level) {
      case SkillLevel.beginner:
        return 0.25;
      case SkillLevel.intermediate:
        return 0.5;
      case SkillLevel.advanced:
        return 0.75;
      case SkillLevel.expert:
        return 1.0;
    }
  }
  
  /// 獲取技能等級顯示文字
  String getLevelText() {
    switch (level) {
      case SkillLevel.beginner:
        return 'Beginner';
      case SkillLevel.intermediate:
        return 'Intermediate';
      case SkillLevel.advanced:
        return 'Advanced';
      case SkillLevel.expert:
        return 'Expert';
    }
  }
  
  /// 獲取類別名稱
  static String getCategoryName(SkillCategory category) {
    switch (category) {
      case SkillCategory.language:
        return 'Programming Languages';
      case SkillCategory.framework:
        return 'Frameworks';
      case SkillCategory.mobile:
        return 'Mobile Development';
      case SkillCategory.web:
        return 'Web Development';
      case SkillCategory.backend:
        return 'Backend & APIs';
      case SkillCategory.devops:
        return 'DevOps & CI/CD';
      case SkillCategory.ai:
        return 'AI & Machine Learning';
      case SkillCategory.design:
        return 'UI/UX Design';
      case SkillCategory.soft:
        return 'Soft Skills';
    }
  }
  
  /// 獲取類別顏色
  static Color getCategoryColor(SkillCategory category, BuildContext context) {
    final theme = Theme.of(context);
    
    switch (category) {
      case SkillCategory.language:
        return theme.colorScheme.primary;
      case SkillCategory.framework:
        return theme.colorScheme.secondary;
      case SkillCategory.mobile:
        return Colors.blue;
      case SkillCategory.web:
        return Colors.orange;
      case SkillCategory.backend:
        return Colors.green;
      case SkillCategory.devops:
        return Colors.purple;
      case SkillCategory.ai:
        return Colors.pink;
      case SkillCategory.design:
        return Colors.teal;
      case SkillCategory.soft:
        return Colors.amber;
    }
  }
  
  /// 獲取類別圖標
  static IconData getCategoryIcon(SkillCategory category) {
    switch (category) {
      case SkillCategory.language:
        return Icons.code;
      case SkillCategory.framework:
        return Icons.widgets;
      case SkillCategory.mobile:
        return Icons.smartphone;
      case SkillCategory.web:
        return Icons.web;
      case SkillCategory.backend:
        return Icons.storage;
      case SkillCategory.devops:
        return Icons.integration_instructions;
      case SkillCategory.ai:
        return Icons.psychology;
      case SkillCategory.design:
        return Icons.design_services;
      case SkillCategory.soft:
        return Icons.people;
    }
  }
  
  /// 技能數據
  static List<SkillModel> getSampleSkills() {
    return [
      // 程式語言
      const SkillModel(
        name: 'Dart',
        category: SkillCategory.language,
        level: SkillLevel.expert,
        description: 'Primary language for Flutter development. Extensive experience with async programming, generics, and strong typing features.',
        yearsOfExperience: 5,
        projects: ['Flutter E-Commerce App', 'Portfolio Website'],
      ),
      const SkillModel(
        name: 'Kotlin',
        category: SkillCategory.language,
        level: SkillLevel.advanced,
        description: 'Modern language for Android development. Proficient with coroutines, extensions, and functional programming concepts.',
        yearsOfExperience: 4,
        projects: ['Android Social Media App'],
      ),
      const SkillModel(
        name: 'JavaScript/TypeScript',
        category: SkillCategory.language,
        level: SkillLevel.advanced,
        description: 'Used for web development and backend services. Strong experience with ES6+ features, TypeScript typing system, and async patterns.',
        yearsOfExperience: 6,
        projects: ['Web Analytics Dashboard', 'Node.js Microservices'],
      ),
      const SkillModel(
        name: 'Python',
        category: SkillCategory.language,
        level: SkillLevel.intermediate,
        description: 'Used for backend services, data analysis, and machine learning. Familiar with Flask, Django, and scientific computing libraries.',
        yearsOfExperience: 3,
        projects: ['AI Language Learning Tool', 'Data Analysis Pipeline'],
      ),
      const SkillModel(
        name: 'Swift',
        category: SkillCategory.language,
        level: SkillLevel.intermediate,
        description: 'Used for native iOS application development. Familiar with Swift UI, Combine, and concurrency patterns.',
        yearsOfExperience: 2,
        projects: ['iOS Fitness Tracker'],
      ),
      
      // 框架
      const SkillModel(
        name: 'Flutter',
        category: SkillCategory.framework,
        level: SkillLevel.expert,
        description: 'Expert-level knowledge in Flutter framework for building cross-platform applications. Deep understanding of widget system, state management, and performance optimization.',
        yearsOfExperience: 5,
        projects: ['Flutter E-Commerce App', 'AI Health Assistant', 'Portfolio Website'],
      ),
      const SkillModel(
        name: 'React',
        category: SkillCategory.framework,
        level: SkillLevel.advanced,
        description: 'Advanced proficiency in React for web application development. Experienced with hooks, context API, and state management libraries like Redux.',
        yearsOfExperience: 4,
        projects: ['Web Analytics Dashboard', 'Admin Dashboard'],
      ),
      const SkillModel(
        name: 'Angular',
        category: SkillCategory.framework,
        level: SkillLevel.intermediate,
        description: 'Solid understanding of Angular framework for enterprise web applications. Experienced with components, services, and RxJS.',
        yearsOfExperience: 3,
        projects: ['Enterprise CRM System'],
      ),
      const SkillModel(
        name: 'TensorFlow',
        category: SkillCategory.framework,
        level: SkillLevel.intermediate,
        description: 'Working knowledge of TensorFlow for machine learning model development and deployment. Experience with TensorFlow Lite for mobile applications.',
        yearsOfExperience: 2,
        projects: ['AI Language Learning Tool', 'Image Recognition System'],
      ),
      
      // 移動開發
      const SkillModel(
        name: 'Android (Native)',
        category: SkillCategory.mobile,
        level: SkillLevel.advanced,
        description: 'Advanced knowledge of Android development with Kotlin. Proficient with Jetpack components, MVVM architecture, and Material Design.',
        yearsOfExperience: 6,
        projects: ['Android Social Media App', 'E-commerce Android App'],
      ),
      const SkillModel(
        name: 'iOS (Native)',
        category: SkillCategory.mobile,
        level: SkillLevel.intermediate,
        description: 'Solid understanding of iOS development with Swift. Familiar with UIKit, SwiftUI, and iOS design patterns.',
        yearsOfExperience: 3,
        projects: ['iOS Fitness Tracker', 'iOS Banking App'],
      ),
      const SkillModel(
        name: 'React Native',
        category: SkillCategory.mobile,
        level: SkillLevel.intermediate,
        description: 'Experience developing cross-platform mobile applications with React Native. Familiar with native modules integration and performance optimization.',
        yearsOfExperience: 2,
        projects: ['Messaging App', 'Food Delivery App'],
      ),
      const SkillModel(
        name: 'Mobile UX Design',
        category: SkillCategory.mobile,
        level: SkillLevel.advanced,
        description: 'Strong understanding of mobile UX principles and best practices. Experienced in designing intuitive and accessible mobile interfaces.',
        yearsOfExperience: 5,
        projects: ['Flutter E-Commerce App', 'AI Health Assistant'],
      ),
      
      // Web 開發
      const SkillModel(
        name: 'HTML/CSS/SASS',
        category: SkillCategory.web,
        level: SkillLevel.advanced,
        description: 'Advanced knowledge of modern HTML5, CSS3, and SASS. Proficient with responsive design, animations, and CSS frameworks.',
        yearsOfExperience: 7,
        projects: ['Portfolio Website', 'Web Analytics Dashboard'],
      ),
      const SkillModel(
        name: 'Progressive Web Apps',
        category: SkillCategory.web,
        level: SkillLevel.advanced,
        description: 'Experience building progressive web applications with offline support, push notifications, and app-like experience.',
        yearsOfExperience: 4,
        projects: ['E-commerce PWA', 'News Reader PWA'],
      ),
      const SkillModel(
        name: 'GraphQL',
        category: SkillCategory.web,
        level: SkillLevel.intermediate,
        description: 'Knowledge of GraphQL for efficient API queries. Experience with Apollo Client and server implementation.',
        yearsOfExperience: 3,
        projects: ['Web Analytics Dashboard', 'Social Media Platform'],
      ),
      
      // 後端和 API
      const SkillModel(
        name: 'Node.js',
        category: SkillCategory.backend,
        level: SkillLevel.advanced,
        description: 'Advanced proficiency in Node.js for backend development. Experienced with Express, NestJS, and microservice architecture.',
        yearsOfExperience: 5,
        projects: ['RESTful API Service', 'Real-time Chat Backend'],
      ),
      const SkillModel(
        name: 'Firebase',
        category: SkillCategory.backend,
        level: SkillLevel.expert,
        description: 'Expert-level knowledge of Firebase platform for backend services. Deep understanding of Firestore, Authentication, Cloud Functions, and Hosting.',
        yearsOfExperience: 6,
        projects: ['Flutter E-Commerce App', 'Real-time Social App'],
      ),
      const SkillModel(
        name: 'RESTful APIs',
        category: SkillCategory.backend,
        level: SkillLevel.expert,
        description: 'Extensive experience designing and implementing RESTful APIs. Strong knowledge of API security, versioning, and documentation.',
        yearsOfExperience: 7,
        projects: ['E-commerce Platform API', 'Mobile App Backend'],
      ),
      const SkillModel(
        name: 'SQL Databases',
        category: SkillCategory.backend,
        level: SkillLevel.advanced,
        description: 'Advanced knowledge of SQL databases including PostgreSQL and MySQL. Proficient with query optimization, transactions, and database design.',
        yearsOfExperience: 5,
        projects: ['Analytics Database', 'E-commerce Platform'],
      ),
      const SkillModel(
        name: 'NoSQL Databases',
        category: SkillCategory.backend,
        level: SkillLevel.advanced,
        description: 'Strong experience with NoSQL databases including MongoDB and Firestore. Knowledge of document-based data modeling and scaling strategies.',
        yearsOfExperience: 5,
        projects: ['Real-time Chat App', 'Content Management System'],
      ),
      
      // DevOps & CI/CD
      const SkillModel(
        name: 'Docker',
        category: SkillCategory.devops,
        level: SkillLevel.intermediate,
        description: 'Solid understanding of containerization with Docker. Experience creating and optimizing Docker images and managing containers.',
        yearsOfExperience: 3,
        projects: ['Microservices Platform', 'Development Environment Setup'],
      ),
      const SkillModel(
        name: 'GitHub Actions',
        category: SkillCategory.devops,
        level: SkillLevel.advanced,
        description: 'Advanced knowledge of GitHub Actions for CI/CD pipelines. Experience automating testing, building, and deployment workflows.',
        yearsOfExperience: 4,
        projects: ['Flutter App CI/CD', 'Web App Deployment'],
      ),
      const SkillModel(
        name: 'Cloud Platforms',
        category: SkillCategory.devops,
        level: SkillLevel.intermediate,
        description: 'Experience with various cloud platforms including AWS, Google Cloud, and Azure. Familiar with serverless computing and cloud infrastructure management.',
        yearsOfExperience: 3,
        projects: ['Serverless API', 'Cloud-based Analytics System'],
      ),
      
      // AI & 機器學習
      const SkillModel(
        name: 'Machine Learning',
        category: SkillCategory.ai,
        level: SkillLevel.intermediate,
        description: 'Working knowledge of machine learning concepts and applications. Experience implementing classification, regression, and clustering models.',
        yearsOfExperience: 2,
        projects: ['AI Health Assistant', 'Recommendation System'],
      ),
      const SkillModel(
        name: 'NLP',
        category: SkillCategory.ai,
        level: SkillLevel.intermediate,
        description: 'Experience with natural language processing techniques and libraries. Familiar with sentiment analysis, text classification, and language modeling.',
        yearsOfExperience: 2,
        projects: ['AI Language Learning Tool', 'Chatbot System'],
      ),
      
      // UI/UX 設計
      const SkillModel(
        name: 'UI Design',
        category: SkillCategory.design,
        level: SkillLevel.advanced,
        description: 'Strong skills in user interface design for mobile and web applications. Proficient with design systems, typography, and visual hierarchy.',
        yearsOfExperience: 5,
        projects: ['Flutter E-Commerce App', 'Web Analytics Dashboard'],
      ),
      const SkillModel(
        name: 'Figma',
        category: SkillCategory.design,
        level: SkillLevel.advanced,
        description: 'Advanced proficiency in Figma for UI/UX design. Experienced with components, prototyping, and design collaboration.',
        yearsOfExperience: 4,
        projects: ['Design System Creation', 'App UI Mockups'],
      ),
      const SkillModel(
        name: 'Accessibility',
        category: SkillCategory.design,
        level: SkillLevel.intermediate,
        description: 'Knowledge of web and mobile accessibility standards (WCAG). Experience implementing accessible interfaces for diverse user needs.',
        yearsOfExperience: 3,
        projects: ['Accessible E-commerce Platform', 'Government Institution Website'],
      ),
      
      // 軟技能
      const SkillModel(
        name: 'Team Leadership',
        category: SkillCategory.soft,
        level: SkillLevel.advanced,
        description: 'Experience leading development teams and managing projects. Strong skills in team coordination, mentoring, and strategic planning.',
        yearsOfExperience: 5,
        projects: ['Led 5-person development team', 'Managed multiple project deliveries'],
      ),
      const SkillModel(
        name: 'Technical Communication',
        category: SkillCategory.soft,
        level: SkillLevel.expert,
        description: 'Excellent ability to communicate complex technical concepts clearly. Experienced in documentation, presentations, and client communication.',
        yearsOfExperience: 8,
        projects: ['Technical documentation', 'Client presentations', 'Conference speaking'],
      ),
      const SkillModel(
        name: 'Agile Methodologies',
        category: SkillCategory.soft,
        level: SkillLevel.advanced,
        description: 'Strong knowledge of agile development practices. Experienced with Scrum, Kanban, and continuous improvement processes.',
        yearsOfExperience: 6,
        projects: ['Agile team coordination', 'Sprint planning and retrospectives'],
      ),
    ];
  }
  
  /// 獲取按類別分組的技能
  static Map<SkillCategory, List<SkillModel>> getSkillsByCategory() {
    final skills = getSampleSkills();
    final map = <SkillCategory, List<SkillModel>>{};
    
    for (final category in SkillCategory.values) {
      map[category] = skills.where((skill) => skill.category == category).toList();
    }
    
    return map;
  }
} 