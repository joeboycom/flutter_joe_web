import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class GitHubStats extends StatelessWidget {
  final String username;
  
  const GitHubStats({
    super.key,
    required this.username,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 標題
          Row(
            children: [
              FaIcon(FontAwesomeIcons.github, size: 24),
              const SizedBox(width: 12),
              Text(
                'GitHub Activity & Stats',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              OutlinedButton.icon(
                onPressed: () => _launchUrl('https://github.com/$username'),
                icon: const Icon(Icons.open_in_new, size: 16),
                label: const Text('View Profile'),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // 主要統計數據
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatCard(
                context,
                'Repositories',
                '52',
                Icons.folder,
              ),
              _buildStatCard(
                context,
                'Contributions',
                '2.4k',
                Icons.add_circle_outline,
              ),
              _buildStatCard(
                context,
                'Stars Earned',
                '3.7k',
                Icons.star_border,
              ),
              _buildStatCard(
                context,
                'Followers',
                '476',
                Icons.people_outline,
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // 貢獻圖標題
          Text(
            'Contribution Activity',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // 貢獻圖（使用SVG佔位符）
          // 在真實環境中，這裡應該是一個從GitHub API獲取的實際貢獻圖
          Center(
            child: AspectRatio(
              aspectRatio: 3.5,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _buildContributionGraph(context),
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // 貢獻圖說明
          Center(
            child: Text(
              'Joe\'s GitHub contributions over the past year',
              style: theme.textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // 語言統計標題
          Text(
            'Top Languages',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // 語言統計
          Row(
            children: [
              Expanded(
                child: _buildLanguageProgressBar(
                  context,
                  'Dart',
                  0.65,
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildLanguageProgressBar(
                  context,
                  'JavaScript',
                  0.12,
                  Colors.yellow.shade700,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: _buildLanguageProgressBar(
                  context,
                  'TypeScript',
                  0.10,
                  Colors.blue.shade800,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildLanguageProgressBar(
                  context,
                  'Python',
                  0.08,
                  Colors.green.shade600,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: _buildLanguageProgressBar(
                  context,
                  'Kotlin',
                  0.03,
                  Colors.purple,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildLanguageProgressBar(
                  context,
                  'Other',
                  0.02,
                  Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms);
  }
  
  // 構建統計卡片
  Widget _buildStatCard(BuildContext context, String label, String value, IconData icon) {
    final theme = Theme.of(context);
    
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: theme.colorScheme.primary,
            size: 24,
          ),
        ),
        
        const SizedBox(height: 8),
        
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        
        const SizedBox(height: 4),
        
        Text(
          label,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
  
  // 構建語言進度條
  Widget _buildLanguageProgressBar(BuildContext context, String language, double percentage, Color color) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              language,
              style: theme.textTheme.bodyMedium,
            ),
            const Spacer(),
            Text(
              '${(percentage * 100).toInt()}%',
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 8),
        
        // 進度條
        Stack(
          children: [
            // 背景
            Container(
              height: 6,
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            
            // 前景
            Container(
              height: 6,
              width: MediaQuery.of(context).size.width * percentage * 0.4, // 近似計算，實際寬度需要根據父容器計算
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  // 構建貢獻圖
  Widget _buildContributionGraph(BuildContext context) {
    final theme = Theme.of(context);
    const int rows = 7;
    const int cols = 52;
    const double cellSize = 12;
    const double cellPadding = 2;
    
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 1,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(cols, (col) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(rows, (row) {
                  // 生成隨機強度的貢獻色塊
                  final double intensity = (row * col) % 5 / 4;
                  final color = intensity == 0
                      ? theme.colorScheme.surfaceVariant.withOpacity(0.5)
                      : theme.colorScheme.primary.withOpacity(0.2 + intensity * 0.8);
                  
                  return Padding(
                    padding: const EdgeInsets.all(cellPadding),
                    child: Container(
                      width: cellSize,
                      height: cellSize,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  );
                }),
              );
            }),
          ),
        );
      },
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
} 