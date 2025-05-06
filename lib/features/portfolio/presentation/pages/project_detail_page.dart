import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_joe_web/features/portfolio/presentation/models/project_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProjectDetailPage extends StatelessWidget {
  final String projectId;
  
  const ProjectDetailPage({super.key, required this.projectId});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    
    // 嘗試獲取項目數據
    final projects = ProjectModel.getSampleProjects();
    final project = projects.firstWhere(
      (p) => p.id == projectId,
      orElse: () => projects.first, // 如果找不到，使用第一個項目作為後備
    );
    
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 回到作品集的按鈕
            TextButton.icon(
              onPressed: () => context.go('/portfolio'),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back to Portfolio'),
            ).animate().fadeIn(duration: 400.ms),
            
            const SizedBox(height: 24),
            
            // 項目標題和年份
            Row(
              children: [
                Expanded(
                  child: Text(
                    project.title,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    project.year.toString(),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ).animate().fadeIn(duration: 600.ms, delay: 100.ms),
            
            const SizedBox(height: 24),
            
            // 主要內容部分
            if (isDesktop)
              // 桌面布局：左右兩欄
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 左側：概覽和詳情
                  Expanded(
                    flex: 3,
                    child: _buildProjectOverview(context, project),
                  ),
                  
                  const SizedBox(width: 48),
                  
                  // 右側：縮略圖和技術數據
                  Expanded(
                    flex: 2,
                    child: _buildProjectSidebar(context, project),
                  ),
                ],
              )
            else
              // 移動設備布局：垂直堆疊
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 縮略圖和技術數據
                  _buildProjectSidebar(context, project),
                  
                  const SizedBox(height: 32),
                  
                  // 概覽和詳情
                  _buildProjectOverview(context, project),
                ],
              ),
            
            const SizedBox(height: 64),
            
            // 挑戰與解決方案部分
            if (project.challenges != null && project.challenges!.isNotEmpty)
              _buildChallengesSection(context, project),
            
            const SizedBox(height: 64),
            
            // 其他項目顯示
            _buildOtherProjectsSection(context, projects, project),
          ],
        ),
      ),
    );
  }
  
  // 項目概覽部分
  Widget _buildProjectOverview(BuildContext context, ProjectModel project) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 概覽標題
        Text(
          'Overview',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
        
        const SizedBox(height: 16),
        
        // 項目概述
        Text(
          project.description,
          style: theme.textTheme.bodyLarge,
        ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
        
        if (project.detailedDescription != null) ...[
          const SizedBox(height: 24),
          
          // 詳細描述
          Text(
            project.detailedDescription!,
            style: theme.textTheme.bodyMedium,
          ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
        ],
        
        const SizedBox(height: 32),
        
        // 項目成果
        if (project.achievements != null && project.achievements!.isNotEmpty)
          _buildAchievementsSection(context, project),
      ],
    );
  }
  
  // 項目側邊欄
  Widget _buildProjectSidebar(BuildContext context, ProjectModel project) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 項目縮略圖
        AspectRatio(
          aspectRatio: 16/9,
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: project.thumbnail != null
                ? Image.asset(
                    project.thumbnail!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildThumbnailPlaceholder(context, project);
                    },
                  )
                : _buildThumbnailPlaceholder(context, project),
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
        
        const SizedBox(height: 32),
        
        // 項目信息卡片
        Container(
          width: double.infinity,
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
              // 項目類別
              Text(
                'Category',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 8),
              
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: project.categories.map((category) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: ProjectModel.getCategoryColor(category, context).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: ProjectModel.getCategoryColor(category, context).withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          ProjectModel.getCategoryIcon(category),
                          size: 16,
                          color: ProjectModel.getCategoryColor(category, context),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          ProjectModel.getCategoryName(category),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: ProjectModel.getCategoryColor(category, context),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              
              const SizedBox(height: 24),
              
              // 技術棧
              Text(
                'Technologies',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 8),
              
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: project.technologies.map((tech) {
                  return Chip(
                    label: Text(tech),
                    backgroundColor: theme.colorScheme.surfaceVariant,
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                  );
                }).toList(),
              ),
              
              const SizedBox(height: 24),
              
              // 客戶信息
              if (project.clientName != null) ...[
                Text(
                  'Client',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                Text(
                  project.clientName!,
                  style: theme.textTheme.bodyMedium,
                ),
                
                const SizedBox(height: 24),
              ],
              
              // 項目鏈接
              if (project.projectLink != null || project.sourceCodeLink != null) ...[
                Text(
                  'Links',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                if (project.projectLink != null)
                  _buildLinkButton(
                    context,
                    'View Project',
                    FontAwesomeIcons.globe,
                    project.projectLink!,
                    isDesktop,
                  ),
                
                if (project.sourceCodeLink != null)
                  _buildLinkButton(
                    context,
                    'Source Code',
                    FontAwesomeIcons.github,
                    project.sourceCodeLink!,
                    isDesktop,
                  ),
              ],
            ],
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
      ],
    );
  }
  
  // 構建縮略圖佔位符
  Widget _buildThumbnailPlaceholder(BuildContext context, ProjectModel project) {
    final theme = Theme.of(context);
    IconData icon = Icons.work;
    
    if (project.categories.contains(ProjectCategory.mobile)) {
      icon = Icons.smartphone;
    } else if (project.categories.contains(ProjectCategory.web)) {
      icon = Icons.web;
    } else if (project.categories.contains(ProjectCategory.ai)) {
      icon = Icons.psychology;
    } else if (project.categories.contains(ProjectCategory.openSource)) {
      icon = Icons.code;
    }
    
    return Container(
      color: theme.colorScheme.surfaceVariant,
      alignment: Alignment.center,
      child: Icon(
        icon,
        size: 64,
        color: theme.colorScheme.primary.withOpacity(0.3),
      ),
    );
  }
  
  // 構建連結按鈕
  Widget _buildLinkButton(
    BuildContext context,
    String label,
    IconData icon,
    String url,
    bool isDesktop,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ElevatedButton.icon(
        onPressed: () {
          // TODO: 實現 URL 啟動功能
          print('Opening URL: $url');
        },
        icon: FaIcon(icon, size: 16),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(isDesktop ? 200 : double.infinity, 44),
        ),
      ),
    );
  }
  
  // 構建成果部分
  Widget _buildAchievementsSection(BuildContext context, ProjectModel project) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Achievements',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 500.ms),
        
        const SizedBox(height: 24),
        
        isDesktop
            ? Row(
                children: project.achievements!.entries.map((entry) {
                  return Expanded(
                    child: _buildAchievementCard(context, entry.key, entry.value),
                  );
                }).toList(),
              )
            : Column(
                children: project.achievements!.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: _buildAchievementCard(context, entry.key, entry.value),
                  );
                }).toList(),
              ),
      ],
    );
  }
  
  // 構建單個成果卡片
  Widget _buildAchievementCard(BuildContext context, String key, String value) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 0,
      color: theme.colorScheme.primary.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            
            const SizedBox(height: 8),
            
            Text(
              key.toUpperCase(),
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 600.ms);
  }
  
  // 構建挑戰與解決方案部分
  Widget _buildChallengesSection(BuildContext context, ProjectModel project) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Challenges & Solutions',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 700.ms),
        
        const SizedBox(height: 24),
        
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: project.challenges!.length,
          itemBuilder: (context, index) {
            final challenge = project.challenges![index];
            final solution = project.solutions != null && index < project.solutions!.length
                ? project.solutions![index]
                : null;
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 索引圓圈
                  Container(
                    width: 28,
                    height: 28,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.colorScheme.primary,
                    ),
                    child: Text(
                      '${index + 1}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // 挑戰和解決方案
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 挑戰
                        Text(
                          'Challenge:',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.error,
                          ),
                        ),
                        
                        const SizedBox(height: 4),
                        
                        Text(
                          challenge,
                          style: theme.textTheme.bodyMedium,
                        ),
                        
                        // 解決方案
                        if (solution != null) ...[
                          const SizedBox(height: 16),
                          
                          Text(
                            'Solution:',
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          
                          const SizedBox(height: 4),
                          
                          Text(
                            solution,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 600.ms, delay: Duration(milliseconds: 700 + 100 * index));
          },
        ),
      ],
    );
  }
  
  // 構建其他項目部分
  Widget _buildOtherProjectsSection(
    BuildContext context,
    List<ProjectModel> allProjects,
    ProjectModel currentProject,
  ) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    
    // 過濾出其他項目（最多3個）
    final otherProjects = allProjects
        .where((p) => p.id != currentProject.id)
        .take(3)
        .toList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Explore More Projects',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 800.ms),
        
        const SizedBox(height: 24),
        
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isDesktop ? 3 : ResponsiveBreakpoints.of(context).isMobile ? 1 : 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.0,
          ),
          itemCount: otherProjects.length,
          itemBuilder: (context, index) {
            final project = otherProjects[index];
            
            return Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                onTap: () => context.go('/portfolio/${project.id}'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 縮略圖
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: theme.colorScheme.surfaceVariant,
                        child: project.thumbnail != null
                            ? Image.asset(
                                project.thumbnail!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    ProjectModel.getCategoryIcon(project.categories.first),
                                    size: 48,
                                    color: theme.colorScheme.primary.withOpacity(0.3),
                                  );
                                },
                              )
                            : Icon(
                                ProjectModel.getCategoryIcon(project.categories.first),
                                size: 48,
                                color: theme.colorScheme.primary.withOpacity(0.3),
                              ),
                      ),
                    ),
                    
                    // 標題
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project.title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          
                          const SizedBox(height: 4),
                          
                          Text(
                            project.description,
                            style: theme.textTheme.bodySmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(duration: 600.ms, delay: Duration(milliseconds: 900 + 100 * index));
          },
        ),
        
        const SizedBox(height: 32),
        
        // 查看所有項目按鈕
        Center(
          child: ElevatedButton.icon(
            onPressed: () => context.go('/portfolio'),
            icon: const Icon(Icons.grid_view),
            label: const Text('View All Projects'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
            ),
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 1000.ms),
      ],
    );
  }
} 