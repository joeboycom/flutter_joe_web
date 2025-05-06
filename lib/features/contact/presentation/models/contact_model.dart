import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// 聯絡方式類型枚舉
enum ContactMethodType {
  email,
  phone,
  location,
  social,
}

/// 社交平台類型枚舉
enum SocialPlatformType {
  linkedin,
  github,
  twitter,
  facebook,
  instagram,
  youtube,
  medium,
  stackoverflow,
}

/// 聯絡方式模型類
class ContactMethodModel {
  final String title;
  final String value;
  final ContactMethodType type;
  final IconData icon;
  final String? url;

  const ContactMethodModel({
    required this.title,
    required this.value,
    required this.type,
    required this.icon,
    this.url,
  });
  
  /// 獲取示例聯絡方式數據
  static List<ContactMethodModel> getSampleContactMethods() {
    return [
      const ContactMethodModel(
        title: 'Email',
        value: 'joe.wu@example.com',
        type: ContactMethodType.email,
        icon: Icons.email,
        url: 'mailto:joe.wu@example.com',
      ),
      const ContactMethodModel(
        title: 'Phone',
        value: '+1 (123) 456-7890',
        type: ContactMethodType.phone,
        icon: Icons.phone,
        url: 'tel:+11234567890',
      ),
      const ContactMethodModel(
        title: 'Location',
        value: 'San Francisco, CA',
        type: ContactMethodType.location,
        icon: Icons.location_on,
      ),
    ];
  }
}

/// 社交平台模型類
class SocialPlatformModel {
  final String name;
  final SocialPlatformType type;
  final IconData icon;
  final String url;
  final Color color;

  const SocialPlatformModel({
    required this.name,
    required this.type,
    required this.icon,
    required this.url,
    required this.color,
  });
  
  /// 獲取示例社交平台數據
  static List<SocialPlatformModel> getSampleSocialPlatforms() {
    return [
      SocialPlatformModel(
        name: 'LinkedIn',
        type: SocialPlatformType.linkedin,
        icon: FontAwesomeIcons.linkedin,
        url: 'https://www.linkedin.com/in/joe-wu/',
        color: const Color(0xFF0077B5),
      ),
      SocialPlatformModel(
        name: 'GitHub',
        type: SocialPlatformType.github,
        icon: FontAwesomeIcons.github,
        url: 'https://github.com/joewu',
        color: const Color(0xFF333333),
      ),
      SocialPlatformModel(
        name: 'Twitter',
        type: SocialPlatformType.twitter,
        icon: FontAwesomeIcons.twitter,
        url: 'https://twitter.com/joewu',
        color: const Color(0xFF1DA1F2),
      ),
      SocialPlatformModel(
        name: 'Medium',
        type: SocialPlatformType.medium,
        icon: FontAwesomeIcons.medium,
        url: 'https://medium.com/@joewu',
        color: const Color(0xFF00AB6C),
      ),
      SocialPlatformModel(
        name: 'Stack Overflow',
        type: SocialPlatformType.stackoverflow,
        icon: FontAwesomeIcons.stackOverflow,
        url: 'https://stackoverflow.com/users/123456/joe-wu',
        color: const Color(0xFFF48024),
      ),
    ];
  }
} 