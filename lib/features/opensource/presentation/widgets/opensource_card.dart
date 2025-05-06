import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_joe_web/features/opensource/presentation/models/opensource_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenSourceCard extends StatelessWidget {
  final OpenSourceModel project;
  final int index;
  
  const OpenSourceCard({
    super.key,
    required this.project,
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
        onTap: () {
          if (project.repoUrl != null) {
            _launchUrl(project.repoUrl!);
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 項目名稱和類型
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 項目類型圖標
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getTypeColor(context).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      project.getTypeIcon(),
                      color: _getTypeColor(context),
                      size: 20,
                    ),
                  ),
                  
                  const SizedBox(width: 12),
                  
                  // 項目名稱和組織
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                        if (project.organization != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            project.organization!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  
                  // 類型標籤
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getTypeColor(context).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      project.getTypeName(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: _getTypeColor(context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // 項目描述
              Text(
                project.description,
                style: theme.textTheme.bodyMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              
              const SizedBox(height: 16),
              
              // 語言標籤（如果有）
              if (project.language != null) ...[
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: project.languageColor ?? Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      project.language!,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
              ],
              
              // 項目統計
              if (_shouldShowStats()) ...[
                Row(
                  children: [
                    // Stars
                    _buildStatItem(
                      context,
                      Icons.star_border,
                      '${_formatNumber(project.stars)}',
                      'Stars',
                    ),
                    
                    const SizedBox(width: 16),
                    
                    // Forks
                    _buildStatItem(
                      context,
                      FontAwesomeIcons.codeFork,
                      '${_formatNumber(project.forks)}',
                      'Forks',
                    ),
                    
                    const SizedBox(width: 16),
                    
                    // Issues
                    _buildStatItem(
                      context,
                      Icons.error_outline,
                      '${_formatNumber(project.issues)}',
                      'Issues',
                    ),
                    
                    const SizedBox(width: 16),
                    
                    // Pull Requests
                    _buildStatItem(
                      context,
                      Icons.call_merge,
                      '${_formatNumber(project.pullRequests)}',
                      'PRs',
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
              ],
              
              // 主題標籤
              if (project.topics != null && project.topics!.isNotEmpty) ...[
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: project.topics!.take(5).map((topic) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: theme.colorScheme.outline.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        topic,
                        style: theme.textTheme.bodySmall,
                      ),
                    );
                  }).toList(),
                ),
                
                const SizedBox(height: 16),
              ],
              
              // 最後更新時間
              Row(
                children: [
                  Icon(
                    Icons.update,
                    size: 16,
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Updated ${DateFormat('MMMM d, yyyy').format(project.lastUpdated)}',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: Duration(milliseconds: 100 * index));
  }
  
  // 構建統計項
  Widget _buildStatItem(BuildContext context, IconData icon, String count, String label) {
    final theme = Theme.of(context);
    
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: theme.colorScheme.onSurface.withOpacity(0.6),
        ),
        const SizedBox(width: 4),
        Text(
          count,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
  
  // 獲取類型顏色
  Color _getTypeColor(BuildContext context) {
    final theme = Theme.of(context);
    
    switch (project.type) {
      case OpenSourceType.repository:
        return theme.colorScheme.primary;
      case OpenSourceType.contribution:
        return Colors.purple;
      case OpenSourceType.community:
        return Colors.orange;
    }
  }
  
  // 是否顯示統計數據
  bool _shouldShowStats() {
    return project.stars > 0 || project.forks > 0 || project.issues > 0 || project.pullRequests > 0;
  }
  
  // 數字格式化
  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    } else {
      return number.toString();
    }
  }
  
  // 啟動 URL
  Future<void> _launchUrl(String url) async {
    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      print('Could not launch $url: $e');
    }
  }
} 