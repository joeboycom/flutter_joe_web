import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_joe_web/features/achievements/presentation/models/achievement_model.dart';
import 'package:flutter_joe_web/features/achievements/presentation/widgets/achievement_card.dart';

class AchievementsPage extends StatefulWidget {
  const AchievementsPage({super.key});

  @override
  State<AchievementsPage> createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage> with SingleTickerProviderStateMixin {
  // Tab 控制器
  late TabController _tabController;
  
  // 所有成就
  final List<AchievementModel> _allAchievements = AchievementModel.getSampleAchievements();
  
  // 按類型分組的成就
  late Map<AchievementType, List<AchievementModel>> _achievementsByType;
  
  @override
  void initState() {
    super.initState();
    
    // 初始化分組數據
    _achievementsByType = AchievementModel.getAchievementsByType();
    
    // 初始化 Tab 控制器，tabs 包含全部和所有有成就的類型
    final tabCount = 1 + _achievementsByType.entries
        .where((entry) => entry.value.isNotEmpty)
        .length;
    
    _tabController = TabController(length: tabCount, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    
    // 獲取有內容的成就類型
    final typesWithAchievements = _achievementsByType.entries
        .where((entry) => entry.value.isNotEmpty)
        .map((entry) => entry.key)
        .toList();
    
    return DefaultTabController(
      length: 1 + typesWithAchievements.length,
      child: Column(
        children: [
          // 頁面標題和描述
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Achievements & Media',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ).animate().fadeIn(duration: 600.ms),
                
                const SizedBox(height: 16),
                
                Text(
                  'A collection of my professional accomplishments, recognitions, certifications, and media appearances.',
                  style: theme.textTheme.bodyLarge,
                ).animate().fadeIn(duration: 600.ms, delay: 100.ms),
              ],
            ),
          ),
          
          // 成就標籤頁
          Container(
            margin: const EdgeInsets.only(bottom: 32),
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
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: theme.colorScheme.primary,
              unselectedLabelColor: theme.colorScheme.onSurface,
              indicatorColor: theme.colorScheme.primary,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: theme.textTheme.titleSmall,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              tabs: [
                const Tab(text: 'All'),
                ...typesWithAchievements.map((type) {
                  final count = _achievementsByType[type]?.length ?? 0;
                  return Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(_getIconForType(type), size: 20),
                        const SizedBox(width: 8),
                        Text(_getNameForType(type)),
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            count.toString(),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
          
          // 成就內容
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // 全部成就
                _buildAchievementsGrid(_allAchievements, isDesktop),
                
                // 按類型顯示成就
                ...typesWithAchievements.map((type) {
                  final achievements = _achievementsByType[type] ?? [];
                  return _buildAchievementsGrid(achievements, isDesktop);
                }),
              ],
            ),
          ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
        ],
      ),
    );
  }
  
  // 構建成就網格
  Widget _buildAchievementsGrid(List<AchievementModel> achievements, bool isDesktop) {
    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 32),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isDesktop ? 3 : (ResponsiveBreakpoints.of(context).isMobile ? 1 : 2),
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 0.85,
      ),
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        return AchievementCard(
          achievement: achievements[index],
          index: index,
        );
      },
    );
  }
  
  // 獲取類型名稱
  String _getNameForType(AchievementType type) {
    switch (type) {
      case AchievementType.award:
        return 'Awards';
      case AchievementType.certification:
        return 'Certifications';
      case AchievementType.publication:
        return 'Publications';
      case AchievementType.speaking:
        return 'Speaking';
      case AchievementType.mediaFeature:
        return 'Media';
      case AchievementType.patent:
        return 'Patents';
    }
  }
  
  // 獲取類型圖標
  IconData _getIconForType(AchievementType type) {
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
}
