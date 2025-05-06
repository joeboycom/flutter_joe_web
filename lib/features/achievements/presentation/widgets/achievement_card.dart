import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_joe_web/features/achievements/presentation/models/achievement_model.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AchievementCard extends StatelessWidget {
  final AchievementModel achievement;
  final int index;
  
  const AchievementCard({
    super.key,
    required this.achievement,
    required this.index,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = achievement.getTypeColor(context);
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () => _showAchievementDetails(context),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 成就類型標籤
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              width: double.infinity,
              child: Row(
                children: [
                  Icon(
                    achievement.getTypeIcon(),
                    color: color,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    achievement.getTypeName(),
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            
            // 圖片（如果有）
            if (achievement.imageUrl != null)
              SizedBox(
                height: 160,
                width: double.infinity,
                child: Image.asset(
                  achievement.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: theme.colorScheme.surfaceVariant,
                      alignment: Alignment.center,
                      child: Icon(
                        achievement.getTypeIcon(),
                        size: 48,
                        color: color.withOpacity(0.3),
                      ),
                    );
                  },
                ),
              ),
            
            // 成就內容
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 標題
                  Text(
                    achievement.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // 組織（如果有）
                  if (achievement.organization != null) ...[
                    Row(
                      children: [
                        Icon(
                          Icons.business,
                          size: 16,
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            achievement.organization!,
                            style: theme.textTheme.bodyMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 8),
                  ],
                  
                  // 日期和地點
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        DateFormat('MMMM yyyy').format(achievement.date),
                        style: theme.textTheme.bodyMedium,
                      ),
                      
                      if (achievement.location != null) ...[
                        const SizedBox(width: 16),
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            achievement.location!,
                            style: theme.textTheme.bodyMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // 描述
                  if (achievement.description != null)
                    Text(
                      achievement.description!,
                      style: theme.textTheme.bodyMedium,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  
                  // 鏈接（如果有）
                  if (achievement.linkUrl != null) ...[
                    const SizedBox(height: 16),
                    _buildLinkButton(context),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: Duration(milliseconds: 100 * index));
  }
  
  // 構建鏈接按鈕
  Widget _buildLinkButton(BuildContext context) {
    final theme = Theme.of(context);
    
    String buttonText;
    switch (achievement.type) {
      case AchievementType.certification:
        buttonText = 'View Credential';
        break;
      case AchievementType.publication:
        buttonText = 'Read Article';
        break;
      case AchievementType.mediaFeature:
        buttonText = 'Read Feature';
        break;
      case AchievementType.patent:
        buttonText = 'View Patent';
        break;
      default:
        buttonText = 'Learn More';
    }
    
    return OutlinedButton.icon(
      onPressed: () => _launchUrl(achievement.linkUrl!),
      icon: Icon(Icons.open_in_new, size: 16),
      label: Text(buttonText),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide(
          color: achievement.getTypeColor(context),
        ),
      ),
    );
  }
  
  // 啟動 URL
  Future<void> _launchUrl(String url) async {
    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      print('Could not launch $url: $e');
    }
  }
  
  // 顯示成就詳情對話框
  void _showAchievementDetails(BuildContext context) {
    final theme = Theme.of(context);
    final color = achievement.getTypeColor(context);
    
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
              maxWidth: 600,
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 標題欄
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        achievement.getTypeIcon(),
                        color: color,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        achievement.getTypeName(),
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                        tooltip: 'Close',
                      ),
                    ],
                  ),
                ),
                
                // 內容區域（可滾動）
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 標題
                        Text(
                          achievement.title,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // 組織（如果有）
                        if (achievement.organization != null) ...[
                          Row(
                            children: [
                              Icon(
                                Icons.business,
                                size: 20,
                                color: theme.colorScheme.onSurface.withOpacity(0.7),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  achievement.organization!,
                                  style: theme.textTheme.titleMedium,
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 12),
                        ],
                        
                        // 日期和地點
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 20,
                              color: theme.colorScheme.onSurface.withOpacity(0.7),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              DateFormat('MMMM yyyy').format(achievement.date),
                              style: theme.textTheme.bodyLarge,
                            ),
                            
                            if (achievement.location != null) ...[
                              const SizedBox(width: 24),
                              Icon(
                                Icons.location_on,
                                size: 20,
                                color: theme.colorScheme.onSurface.withOpacity(0.7),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  achievement.location!,
                                  style: theme.textTheme.bodyLarge,
                                ),
                              ),
                            ],
                          ],
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // 圖片（如果有）
                        if (achievement.imageUrl != null) ...[
                          Container(
                            height: 240,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                achievement.imageUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: theme.colorScheme.surfaceVariant,
                                    alignment: Alignment.center,
                                    child: Icon(
                                      achievement.getTypeIcon(),
                                      size: 64,
                                      color: color.withOpacity(0.3),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 24),
                        ],
                        
                        // 描述
                        if (achievement.description != null) ...[
                          Text(
                            'About this ${achievement.getTypeName().toLowerCase()}',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          
                          const SizedBox(height: 12),
                          
                          Text(
                            achievement.description!,
                            style: theme.textTheme.bodyLarge,
                          ),
                        ],
                        
                        const SizedBox(height: 24),
                        
                        // 鏈接按鈕（如果有）
                        if (achievement.linkUrl != null)
                          Center(
                            child: OutlinedButton.icon(
                              onPressed: () => _launchUrl(achievement.linkUrl!),
                              icon: Icon(Icons.open_in_new),
                              label: Text(_getLinkButtonText(achievement.type)),
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                side: BorderSide(
                                  color: color,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  
  // 獲取鏈接按鈕文本
  String _getLinkButtonText(AchievementType type) {
    switch (type) {
      case AchievementType.certification:
        return 'View Credential';
      case AchievementType.publication:
        return 'Read Full Article';
      case AchievementType.mediaFeature:
        return 'Read Full Feature';
      case AchievementType.patent:
        return 'View Patent Details';
      default:
        return 'View More Details';
    }
  }
} 