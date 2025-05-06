import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_joe_web/features/opensource/presentation/models/opensource_model.dart';
import 'package:flutter_joe_web/features/opensource/presentation/widgets/opensource_card.dart';
import 'package:flutter_joe_web/features/opensource/presentation/widgets/github_stats.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OpenSourcePage extends StatefulWidget {
  const OpenSourcePage({super.key});

  @override
  State<OpenSourcePage> createState() => _OpenSourcePageState();
}

class _OpenSourcePageState extends State<OpenSourcePage> with SingleTickerProviderStateMixin {
  // Tab 控制器
  late TabController _tabController;
  
  // 所有項目
  final List<OpenSourceModel> _allProjects = OpenSourceModel.getSampleProjects();
  
  // 按類型分組的項目
  late Map<OpenSourceType, List<OpenSourceModel>> _projectsByType;
  
  @override
  void initState() {
    super.initState();
    
    // 初始化分組數據
    _projectsByType = OpenSourceModel.getProjectsByType();
    
    // 初始化 Tab 控制器
    _tabController = TabController(length: 4, vsync: this);
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
    
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 頁面標題
            Text(
              'Open Source & Community',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(duration: 600.ms),
            
            const SizedBox(height: 16),
            
            // 頁面描述
            Text(
              'Explore my open-source projects, contributions to the developer community, and ongoing initiatives.',
              style: theme.textTheme.bodyLarge,
            ).animate().fadeIn(duration: 600.ms, delay: 100.ms),
            
            const SizedBox(height: 32),
            
            // GitHub 統計卡片
            GitHubStats(username: 'joewu')
                .animate().fadeIn(duration: 600.ms, delay: 200.ms),
            
            const SizedBox(height: 32),
            
            // 項目標籤頁
            Container(
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
                  const Tab(
                    child: Row(
                      children: [
                        Icon(Icons.dashboard),
                        SizedBox(width: 8),
                        Text('All Projects'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      children: [
                        Icon(Icons.folder),
                        const SizedBox(width: 8),
                        const Text('Repositories'),
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _projectsByType[OpenSourceType.repository]?.length.toString() ?? '0',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      children: [
                        Icon(Icons.code),
                        const SizedBox(width: 8),
                        const Text('Contributions'),
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _projectsByType[OpenSourceType.contribution]?.length.toString() ?? '0',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      children: [
                        Icon(Icons.people),
                        const SizedBox(width: 8),
                        const Text('Community'),
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _projectsByType[OpenSourceType.community]?.length.toString() ?? '0',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
            
            const SizedBox(height: 32),
            
            // 項目網格
            SizedBox(
              height: isDesktop ? 1400 : 2000, // 估計高度，可以根據實際內容調整
              child: TabBarView(
                controller: _tabController,
                children: [
                  // 全部項目
                  _buildProjectsGrid(_allProjects, isDesktop),
                  
                  // 倉庫
                  _buildProjectsGrid(
                    _projectsByType[OpenSourceType.repository] ?? [],
                    isDesktop,
                  ),
                  
                  // 貢獻
                  _buildProjectsGrid(
                    _projectsByType[OpenSourceType.contribution] ?? [],
                    isDesktop,
                  ),
                  
                  // 社群
                  _buildProjectsGrid(
                    _projectsByType[OpenSourceType.community] ?? [],
                    isDesktop,
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
            
            const SizedBox(height: 64),
            
            // 社群貢獻部分
            Container(
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
                      Icon(
                        Icons.people,
                        size: 24,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Community Involvement',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // 社群參與
                  Text(
                    'As an active member of the Flutter and mobile development community, I\'m committed to giving back through various initiatives:',
                    style: theme.textTheme.bodyLarge,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // 社群活動
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: [
                      _buildCommunityActivity(
                        context,
                        'Mentorship Program',
                        'Mentored over 20 early-career developers in Flutter and mobile development',
                        Icons.school,
                      ),
                      _buildCommunityActivity(
                        context,
                        'Conference Speaking',
                        'Presented at 12+ tech conferences on Flutter, accessibility, and mobile AI',
                        Icons.record_voice_over,
                      ),
                      _buildCommunityActivity(
                        context,
                        'Open Source Maintenance',
                        'Actively maintaining 5 popular Flutter packages with 5k+ combined stars',
                        Icons.code,
                      ),
                      _buildCommunityActivity(
                        context,
                        'Technical Articles',
                        'Published 25+ in-depth articles on Flutter development and best practices',
                        Icons.article,
                      ),
                      _buildCommunityActivity(
                        context,
                        'Local Meetups',
                        'Organized and hosted monthly Flutter developer meetups in the community',
                        Icons.groups,
                      ),
                      _buildCommunityActivity(
                        context,
                        'Code Reviews',
                        'Contributed 500+ code reviews to open source projects in the ecosystem',
                        Icons.rate_review,
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // 社區平台
                  Text(
                    'Connect with me on developer platforms:',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // 平台列表
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _buildPlatformChip(
                        context,
                        'GitHub',
                        FontAwesomeIcons.github,
                      ),
                      _buildPlatformChip(
                        context,
                        'Stack Overflow',
                        FontAwesomeIcons.stackOverflow,
                      ),
                      _buildPlatformChip(
                        context,
                        'Dev.to',
                        FontAwesomeIcons.dev,
                      ),
                      _buildPlatformChip(
                        context,
                        'Medium',
                        FontAwesomeIcons.medium,
                      ),
                      _buildPlatformChip(
                        context,
                        'Hashnode',
                        FontAwesomeIcons.hashnode,
                      ),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 500.ms),
          ],
        ),
      ),
    );
  }
  
  // 構建項目網格
  Widget _buildProjectsGrid(List<OpenSourceModel> projects, bool isDesktop) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isDesktop ? 3 : (ResponsiveBreakpoints.of(context).isMobile ? 1 : 2),
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 1.0,
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return OpenSourceCard(
          project: projects[index],
          index: index,
        );
      },
    );
  }
  
  // 構建社群活動卡片
  Widget _buildCommunityActivity(BuildContext context, String title, String description, IconData icon) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    
    return Container(
      width: isDesktop ? 380 : double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: theme.colorScheme.primary,
              size: 24,
            ),
          ),
          
          const SizedBox(width: 16),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 4),
                
                Text(
                  description,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // 構建平台芯片
  Widget _buildPlatformChip(BuildContext context, String label, IconData icon) {
    final theme = Theme.of(context);
    
    return Chip(
      avatar: FaIcon(
        icon,
        size: 16,
        color: theme.colorScheme.primary,
      ),
      label: Text(label),
      backgroundColor: theme.colorScheme.surface,
      side: BorderSide(
        color: theme.colorScheme.outline.withOpacity(0.5),
        width: 1,
      ),
    );
  }
}
