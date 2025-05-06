import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_joe_web/features/contact/presentation/models/contact_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactCard extends StatelessWidget {
  final ContactMethodModel contactMethod;
  final int index;
  
  const ContactCard({
    super.key,
    required this.contactMethod,
    required this.index,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: contactMethod.url != null ? () => _launchUrl(contactMethod.url!) : null,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // 圖標
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  contactMethod.icon,
                  color: theme.colorScheme.primary,
                  size: 32,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // 標題
              Text(
                contactMethod.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 8),
              
              // 值
              Text(
                contactMethod.value,
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 16),
              
              // 如果有URL，顯示一個按鈕
              if (contactMethod.url != null)
                OutlinedButton(
                  onPressed: () => _launchUrl(contactMethod.url!),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide(
                      color: theme.colorScheme.primary,
                      width: 1,
                    ),
                  ),
                  child: Text(_getButtonText()),
                ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: Duration(milliseconds: 100 * index));
  }
  
  // 獲取按鈕文本
  String _getButtonText() {
    switch (contactMethod.type) {
      case ContactMethodType.email:
        return 'Send Email';
      case ContactMethodType.phone:
        return 'Call Now';
      case ContactMethodType.location:
        return 'View on Map';
      case ContactMethodType.social:
        return 'Visit Profile';
    }
  }
  
  // 啟動URL
  Future<void> _launchUrl(String url) async {
    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      print('Could not launch $url: $e');
    }
  }
} 