import 'package:flutter/material.dart';

/// 成就類型枚舉
enum AchievementType {
  award,
  certification,
  publication,
  speaking,
  mediaFeature,
  patent,
}

/// 成就模型類
class AchievementModel {
  final String title;
  final AchievementType type;
  final String? organization;
  final DateTime date;
  final String? description;
  final String? imageUrl;
  final String? linkUrl;
  final String? location;
  
  const AchievementModel({
    required this.title,
    required this.type,
    this.organization,
    required this.date,
    this.description,
    this.imageUrl,
    this.linkUrl,
    this.location,
  });
  
  /// 獲取類型名稱
  String getTypeName() {
    switch (type) {
      case AchievementType.award:
        return 'Award';
      case AchievementType.certification:
        return 'Certification';
      case AchievementType.publication:
        return 'Publication';
      case AchievementType.speaking:
        return 'Speaking';
      case AchievementType.mediaFeature:
        return 'Media Feature';
      case AchievementType.patent:
        return 'Patent';
    }
  }
  
  /// 獲取類型圖標
  IconData getTypeIcon() {
    switch (type) {
      case AchievementType.award:
        return Icons.emoji_events;
      case AchievementType.certification:
        return Icons.verified;
      case AchievementType.publication:
        return Icons.article;
      case AchievementType.speaking:
        return Icons.record_voice_over;
      case AchievementType.mediaFeature:
        return Icons.newspaper;
      case AchievementType.patent:
        return Icons.lightbulb;
    }
  }
  
  /// 獲取類型顏色
  Color getTypeColor(BuildContext context) {
    final theme = Theme.of(context);
    
    switch (type) {
      case AchievementType.award:
        return Colors.amber;
      case AchievementType.certification:
        return theme.colorScheme.primary;
      case AchievementType.publication:
        return Colors.green;
      case AchievementType.speaking:
        return Colors.purple;
      case AchievementType.mediaFeature:
        return Colors.blue;
      case AchievementType.patent:
        return Colors.orange;
    }
  }
  
  /// 示例成就數據
  static List<AchievementModel> getSampleAchievements() {
    return [
      // 獎項
      AchievementModel(
        title: 'Best Mobile App of the Year',
        type: AchievementType.award,
        organization: 'Mobile Excellence Awards',
        date: DateTime(2023, 5, 15),
        description: 'Received the top award for innovation in mobile app development for the AI Health Assistant project, recognized for its impact on healthcare accessibility.',
        imageUrl: 'assets/images/awards/mobile_excellence.jpg',
      ),
      AchievementModel(
        title: 'Innovation in Technology Award',
        type: AchievementType.award,
        organization: 'TechCrunch Disrupt',
        date: DateTime(2022, 9, 10),
        description: 'Honored for outstanding innovation in using Flutter to create cross-platform solutions that significantly improve user experience.',
        imageUrl: 'assets/images/awards/tech_innovation.jpg',
      ),
      AchievementModel(
        title: 'Community Hero Award',
        type: AchievementType.award,
        organization: 'Flutter Community',
        date: DateTime(2021, 11, 5),
        description: 'Recognized for substantial contributions to the Flutter open-source community through packages, tutorials, and mentorship.',
        imageUrl: 'assets/images/awards/community_hero.jpg',
      ),
      
      // 證照/認證
      AchievementModel(
        title: 'Google Certified Flutter Developer',
        type: AchievementType.certification,
        organization: 'Google',
        date: DateTime(2022, 3, 20),
        description: 'Earned the professional certification for Flutter development, demonstrating expertise in building high-quality, production-ready applications.',
        linkUrl: 'https://credential.net/flutter-certification',
        imageUrl: 'assets/images/certifications/flutter_cert.jpg',
      ),
      AchievementModel(
        title: 'AWS Certified Solutions Architect',
        type: AchievementType.certification,
        organization: 'Amazon Web Services',
        date: DateTime(2021, 7, 12),
        description: 'Professional certification validating expertise in designing distributed systems on AWS, with focus on scalability, security, and reliability.',
        linkUrl: 'https://aws.amazon.com/certification/certified-solutions-architect-associate/',
        imageUrl: 'assets/images/certifications/aws_cert.jpg',
      ),
      AchievementModel(
        title: 'Certified Scrum Master',
        type: AchievementType.certification,
        organization: 'Scrum Alliance',
        date: DateTime(2020, 5, 30),
        description: 'Professional certification in Agile project management methodologies, with expertise in facilitating Scrum processes and team productivity.',
        linkUrl: 'https://www.scrumalliance.org/certifications/practitioners/certified-scrummaster-csm',
        imageUrl: 'assets/images/certifications/scrum_cert.jpg',
      ),
      
      // 出版物/論文
      AchievementModel(
        title: 'Flutter in Enterprise: Scaling Mobile Development',
        type: AchievementType.publication,
        organization: 'Medium - Flutter Publication',
        date: DateTime(2023, 2, 15),
        description: 'In-depth article exploring strategies for adopting Flutter in enterprise environments, covering architecture, state management, and team organization.',
        linkUrl: 'https://medium.com/flutter-community/flutter-in-enterprise',
      ),
      AchievementModel(
        title: 'Cross-Platform Performance Optimization Techniques',
        type: AchievementType.publication,
        organization: 'Mobile Dev Conference Proceedings',
        date: DateTime(2022, 8, 5),
        description: 'Research paper presenting novel approaches to optimize performance in cross-platform applications, with specific focus on Flutter and React Native.',
        linkUrl: 'https://mobiledevcon.proceedings/2022/performance-optimization',
      ),
      
      // 演講
      AchievementModel(
        title: 'Building Beautiful, Fast, and Accessible Flutter Applications',
        type: AchievementType.speaking,
        organization: 'Flutter Forward Conference',
        date: DateTime(2023, 6, 12),
        location: 'San Francisco, CA',
        description: 'Keynote presentation demonstrating advanced techniques for creating Flutter applications that are both visually stunning and highly performant while maintaining accessibility.',
        imageUrl: 'assets/images/speaking/flutter_forward.jpg',
      ),
      AchievementModel(
        title: 'The Future of Mobile Development with AI Integration',
        type: AchievementType.speaking,
        organization: 'Mobile Development Summit',
        date: DateTime(2022, 11, 8),
        location: 'Virtual Conference',
        description: 'Panel discussion on how artificial intelligence is transforming mobile application development, including practical examples and future predictions.',
        imageUrl: 'assets/images/speaking/ai_panel.jpg',
      ),
      AchievementModel(
        title: 'Scaling Flutter Teams: Lessons from the Trenches',
        type: AchievementType.speaking,
        organization: 'Flutter Engage',
        date: DateTime(2022, 4, 20),
        location: 'Berlin, Germany',
        description: 'Technical talk sharing best practices and lessons learned from managing large-scale Flutter projects with multiple development teams.',
        imageUrl: 'assets/images/speaking/flutter_engage.jpg',
      ),
      
      // 媒體報導
      AchievementModel(
        title: 'Innovator Spotlight: Revolutionizing Mobile Health Applications',
        type: AchievementType.mediaFeature,
        organization: 'TechCrunch',
        date: DateTime(2023, 3, 25),
        description: 'Featured profile highlighting contributions to the mobile health technology sector and the impact of the AI Health Assistant application.',
        linkUrl: 'https://techcrunch.com/2023/03/25/innovator-spotlight-mobile-health',
        imageUrl: 'assets/images/media/techcrunch.jpg',
      ),
      AchievementModel(
        title: 'How This Developer Is Making Healthcare More Accessible',
        type: AchievementType.mediaFeature,
        organization: 'Wired Magazine',
        date: DateTime(2022, 7, 18),
        description: 'In-depth interview discussing the development of accessible healthcare applications and the role of technology in addressing healthcare disparities.',
        linkUrl: 'https://wired.com/2022/07/developer-healthcare-accessible',
        imageUrl: 'assets/images/media/wired.jpg',
      ),
      
      // 專利
      AchievementModel(
        title: 'Method and System for Predictive Healthcare Analysis Using Mobile Devices',
        type: AchievementType.patent,
        organization: 'US Patent Office',
        date: DateTime(2021, 9, 30),
        description: 'Patent covering a novel approach to analyzing health data collected through mobile devices to provide predictive insights and personalized health recommendations.',
        linkUrl: 'https://patents.google.com/?id=US1234567A',
      ),
    ];
  }
  
  /// 獲取按類型分組的成就
  static Map<AchievementType, List<AchievementModel>> getAchievementsByType() {
    final achievements = getSampleAchievements();
    final map = <AchievementType, List<AchievementModel>>{};
    
    for (final type in AchievementType.values) {
      map[type] = achievements.where((achievement) => achievement.type == type).toList();
    }
    
    return map;
  }
} 