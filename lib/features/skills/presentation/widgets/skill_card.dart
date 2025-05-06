import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_joe_web/features/skills/presentation/models/skill_model.dart';
import 'dart:math' as math;

class SkillCard extends StatelessWidget {
  final SkillModel skill;
  final int index;
  
  const SkillCard({
    super.key,
    required this.skill,
    required this.index,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = SkillModel.getCategoryColor(skill.category, context);
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () => _showSkillDetails(context),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 技能名稱和類別
              Row(
                children: [
                  // 類別圖標
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      SkillModel.getCategoryIcon(skill.category),
                      color: color,
                      size: 20,
                    ),
                  ),
                  
                  const SizedBox(width: 12),
                  
                  // 技能名稱
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          skill.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        
                        const SizedBox(height: 2),
                        
                        Text(
                          SkillModel.getCategoryName(skill.category),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.secondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // 熟練度進度條
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Proficiency',
                        style: theme.textTheme.bodySmall,
                      ),
                      Text(
                        skill.getLevelText(),
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: _getLevelColor(context, skill.level),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // 自定義進度條
                  Stack(
                    children: [
                      // 背景
                      Container(
                        height: 8,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      
                      // 前景
                      Container(
                        height: 8,
                        width: MediaQuery.of(context).size.width * skill.getLevelPercentage() * 0.2, // 寬度乘以0.2因為卡片寬度大約是螢幕寬度的1/5
                        decoration: BoxDecoration(
                          color: _getLevelColor(context, skill.level),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // 經驗年數
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${skill.yearsOfExperience} ${skill.yearsOfExperience == 1 ? 'year' : 'years'} of experience',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
              
              // 相關項目（如果有）
              if (skill.projects != null && skill.projects!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.work,
                      size: 16,
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Used in: ${skill.projects!.join(', ')}',
                        style: theme.textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: Duration(milliseconds: 100 * index));
  }
  
  // 根據技能等級獲取顏色
  Color _getLevelColor(BuildContext context, SkillLevel level) {
    final theme = Theme.of(context);
    
    switch (level) {
      case SkillLevel.beginner:
        return Colors.orange;
      case SkillLevel.intermediate:
        return Colors.blue;
      case SkillLevel.advanced:
        return Colors.purple;
      case SkillLevel.expert:
        return theme.colorScheme.primary;
    }
  }
  
  // 顯示技能詳情對話框
  void _showSkillDetails(BuildContext context) {
    final theme = Theme.of(context);
    
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: math.min(600, MediaQuery.of(context).size.width * 0.8),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 標題和關閉按鈕
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        skill.name,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                
                const SizedBox(height: 8),
                
                // 類別和經驗
                Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  children: [
                    // 類別
                    Chip(
                      avatar: Icon(
                        SkillModel.getCategoryIcon(skill.category),
                        size: 16,
                        color: SkillModel.getCategoryColor(skill.category, context),
                      ),
                      label: Text(SkillModel.getCategoryName(skill.category)),
                      backgroundColor: theme.colorScheme.surfaceVariant,
                    ),
                    
                    // 熟練度
                    Chip(
                      avatar: Icon(
                        Icons.trending_up,
                        size: 16,
                        color: _getLevelColor(context, skill.level),
                      ),
                      label: Text(skill.getLevelText()),
                      backgroundColor: theme.colorScheme.surfaceVariant,
                    ),
                    
                    // 經驗年數
                    Chip(
                      avatar: Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: theme.colorScheme.secondary,
                      ),
                      label: Text('${skill.yearsOfExperience} years'),
                      backgroundColor: theme.colorScheme.surfaceVariant,
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                
                // 描述
                if (skill.description != null) ...[
                  Text(
                    'About this skill',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    skill.description!,
                    style: theme.textTheme.bodyMedium,
                  ),
                  
                  const SizedBox(height: 24),
                ],
                
                // 相關項目
                if (skill.projects != null && skill.projects!.isNotEmpty) ...[
                  Text(
                    'Related Projects',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: skill.projects!.map((project) {
                      return Chip(
                        label: Text(project),
                        backgroundColor: theme.colorScheme.surfaceVariant,
                      );
                    }).toList(),
                  ),
                ],
                
                const SizedBox(height: 24),
                
                // 關閉按鈕
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
} 