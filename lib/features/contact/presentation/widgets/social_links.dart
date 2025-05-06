import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_joe_web/features/contact/presentation/models/contact_model.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialLinks extends StatelessWidget {
  const SocialLinks({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final socialPlatforms = SocialPlatformModel.getSampleSocialPlatforms();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 標題
        Text(
          'Connect with me',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ).animate().fadeIn(duration: 600.ms),
        
        const SizedBox(height: 8),
        
        // 副標題
        Text(
          'Follow me on social media platforms to stay updated with my latest projects and activities.',
          style: theme.textTheme.bodyMedium,
        ).animate().fadeIn(duration: 600.ms, delay: 100.ms),
        
        const SizedBox(height: 24),
        
        // 社交平台網格
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemCount: socialPlatforms.length,
          itemBuilder: (context, index) {
            final platform = socialPlatforms[index];
            return _buildSocialButton(context, platform, index);
          },
        ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
      ],
    );
  }
  
  // 構建社交平台按鈕
  Widget _buildSocialButton(BuildContext context, SocialPlatformModel platform, int index) {
    return InkWell(
      onTap: () => _launchUrl(platform.url),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: platform.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: platform.color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              platform.icon,
              color: platform.color,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              platform.name,
              style: TextStyle(
                color: platform.color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: Duration(milliseconds: 300 + (index * 100)));
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