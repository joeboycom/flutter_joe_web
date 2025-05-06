import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_joe_web/features/portfolio/presentation/models/project_model.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final int index;
  
  const ProjectCard({
    super.key,
    required this.project,
    required this.index,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () => context.go('/portfolio/${project.id}'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 項目縮略圖
            AspectRatio(
              aspectRatio: 16/9,
              child: _buildThumbnail(context),
            ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 項目標題和年份
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          project.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          project.year.toString(),
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // 項目描述
                  Text(
                    project.description,
                    style: theme.textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // 項目類別
                  SizedBox(
                    height: 24,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: project.categories.map((category) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
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
                                  size: 12,
                                  color: ProjectModel.getCategoryColor(category, context),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  ProjectModel.getCategoryName(category),
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: ProjectModel.getCategoryColor(category, context),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // 技術標籤
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: project.technologies.take(4).map((tech) {
                      return Chip(
                        label: Text(
                          tech,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        backgroundColor: theme.colorScheme.surfaceVariant,
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: Duration(milliseconds: 100 * index));
  }
  
  Widget _buildThumbnail(BuildContext context) {
    final theme = Theme.of(context);
    
    // 如果有縮略圖，顯示縮略圖；否則顯示佔位符
    if (project.thumbnail != null) {
      return Container(
        color: theme.colorScheme.surfaceVariant,
        alignment: Alignment.center,
        child: Image.asset(
          project.thumbnail!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            // 如果圖片加載失敗，顯示佔位符
            return _buildPlaceholder(theme);
          },
        ),
      );
    } else {
      return _buildPlaceholder(theme);
    }
  }
  
  Widget _buildPlaceholder(ThemeData theme) {
    return Container(
      color: theme.colorScheme.surfaceVariant,
      alignment: Alignment.center,
      child: Icon(
        _getCategoryIcon(),
        size: 48,
        color: theme.colorScheme.primary.withOpacity(0.3),
      ),
    );
  }
  
  IconData _getCategoryIcon() {
    if (project.categories.contains(ProjectCategory.mobile)) {
      return Icons.smartphone;
    } else if (project.categories.contains(ProjectCategory.web)) {
      return Icons.web;
    } else if (project.categories.contains(ProjectCategory.ai)) {
      return Icons.psychology;
    } else if (project.categories.contains(ProjectCategory.openSource)) {
      return Icons.code;
    } else {
      return Icons.work;
    }
  }
} 