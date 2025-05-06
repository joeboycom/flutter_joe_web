import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_joe_web/features/skills/presentation/models/skill_model.dart';
import 'package:flutter_joe_web/features/skills/presentation/widgets/skill_card.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  // 選擇的類別篩選
  Set<SkillCategory> _selectedCategories = {};
  
  // 選擇的等級篩選
  Set<SkillLevel> _selectedLevels = {};
  
  // 搜索關鍵詞
  String _searchQuery = '';
  
  // 搜索控制器
  final TextEditingController _searchController = TextEditingController();
  
  // 篩選後的技能列表
  late List<SkillModel> _filteredSkills;
  
  // 所有技能
  final List<SkillModel> _allSkills = SkillModel.getSampleSkills();
  
  // 按類別分組的技能
  late Map<SkillCategory, List<SkillModel>> _skillsByCategory;
  
  @override
  void initState() {
    super.initState();
    
    // 初始化分組數據
    _skillsByCategory = SkillModel.getSkillsByCategory();
    
    // 初始化篩選技能列表
    _filteredSkills = List.from(_allSkills);
    
    // 監聽搜索框
    _searchController.addListener(_onSearchChanged);
  }
  
  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }
  
  // 搜索變更時更新篩選
  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
      _filterSkills();
    });
  }
  
  // 切換類別篩選
  void _toggleCategory(SkillCategory category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category);
      } else {
        _selectedCategories.add(category);
      }
      _filterSkills();
    });
  }
  
  // 切換等級篩選
  void _toggleLevel(SkillLevel level) {
    setState(() {
      if (_selectedLevels.contains(level)) {
        _selectedLevels.remove(level);
      } else {
        _selectedLevels.add(level);
      }
      _filterSkills();
    });
  }
  
  // 清除所有篩選條件
  void _clearFilters() {
    setState(() {
      _selectedCategories.clear();
      _selectedLevels.clear();
      _searchController.clear();
      _searchQuery = '';
      _filteredSkills = List.from(_allSkills);
    });
  }
  
  // 根據篩選條件篩選技能
  void _filterSkills() {
    setState(() {
      if (_selectedCategories.isEmpty && _selectedLevels.isEmpty && _searchQuery.isEmpty) {
        // 無篩選條件，顯示所有技能
        _filteredSkills = List.from(_allSkills);
      } else {
        // 應用篩選條件
        _filteredSkills = _allSkills.where((skill) {
          // 檢查類別篩選
          bool matchesCategory = _selectedCategories.isEmpty || 
              _selectedCategories.contains(skill.category);
          
          // 檢查等級篩選
          bool matchesLevel = _selectedLevels.isEmpty || 
              _selectedLevels.contains(skill.level);
          
          // 檢查搜索關鍵詞
          bool matchesSearch = _searchQuery.isEmpty || 
              skill.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              (skill.description?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);
          
          return matchesCategory && matchesLevel && matchesSearch;
        }).toList();
      }
    });
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
              'Skills Matrix',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(duration: 600.ms),
            
            const SizedBox(height: 16),
            
            // 頁面描述
            Text(
              'Explore my technical and professional skills across different domains. Each skill is rated based on proficiency level and years of experience.',
              style: theme.textTheme.bodyLarge,
            ).animate().fadeIn(duration: 600.ms, delay: 100.ms),
            
            const SizedBox(height: 32),
            
            // 篩選與搜索區域
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
                  // 篩選標題
                  Text(
                    'Filter Skills',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // 搜索框
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by skill name or description...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () => _searchController.clear(),
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // 類別篩選標題
                  Text(
                    'Categories',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // 類別篩選器
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: SkillCategory.values.map((category) {
                      return _buildCategoryFilterChip(
                        context,
                        category,
                        SkillModel.getCategoryName(category),
                        SkillModel.getCategoryIcon(category),
                      );
                    }).toList(),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // 等級篩選標題
                  Text(
                    'Proficiency Levels',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // 等級篩選器
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _buildLevelFilterChip(
                        context,
                        SkillLevel.beginner,
                        'Beginner',
                        Colors.orange,
                      ),
                      _buildLevelFilterChip(
                        context,
                        SkillLevel.intermediate,
                        'Intermediate',
                        Colors.blue,
                      ),
                      _buildLevelFilterChip(
                        context,
                        SkillLevel.advanced,
                        'Advanced',
                        Colors.purple,
                      ),
                      _buildLevelFilterChip(
                        context,
                        SkillLevel.expert,
                        'Expert',
                        theme.colorScheme.primary,
                      ),
                      
                      // 清除篩選按鈕
                      if (_selectedCategories.isNotEmpty || _selectedLevels.isNotEmpty || _searchQuery.isNotEmpty)
                        FilterChip(
                          label: const Text('Clear All Filters'),
                          selected: false,
                          onSelected: (_) => _clearFilters(),
                          avatar: const Icon(Icons.clear_all),
                          backgroundColor: theme.colorScheme.surface,
                          side: BorderSide(
                            color: theme.colorScheme.primary,
                            width: 1,
                          ),
                          labelStyle: TextStyle(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
            
            const SizedBox(height: 32),
            
            // 結果計數
            Text(
              'Showing ${_filteredSkills.length} of ${_allSkills.length} skills',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
            
            const SizedBox(height: 32),
            
            // 技能矩陣
            if (_filteredSkills.isEmpty)
              _buildEmptyState(theme)
            else
              _buildSkillsGrid(isDesktop),
              
            const SizedBox(height: 64),
            
            // 按類別分類的技能部分（如果沒有篩選條件）
            if (_selectedCategories.isEmpty && _selectedLevels.isEmpty && _searchQuery.isEmpty)
              _buildSkillsByCategory(isDesktop),
          ],
        ),
      ),
    );
  }
  
  // 構建類別篩選芯片
  Widget _buildCategoryFilterChip(
    BuildContext context,
    SkillCategory category,
    String label,
    IconData icon,
  ) {
    final theme = Theme.of(context);
    final isSelected = _selectedCategories.contains(category);
    final color = SkillModel.getCategoryColor(category, context);
    
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => _toggleCategory(category),
      avatar: Icon(
        icon,
        color: isSelected ? theme.colorScheme.onPrimary : color,
        size: 18,
      ),
      backgroundColor: isSelected ? color : theme.colorScheme.surface,
      selectedColor: color,
      side: BorderSide(
        color: isSelected ? Colors.transparent : color,
        width: 1,
      ),
      labelStyle: TextStyle(
        color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
  
  // 構建等級篩選芯片
  Widget _buildLevelFilterChip(
    BuildContext context,
    SkillLevel level,
    String label,
    Color color,
  ) {
    final theme = Theme.of(context);
    final isSelected = _selectedLevels.contains(level);
    
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => _toggleLevel(level),
      avatar: Icon(
        Icons.trending_up,
        color: isSelected ? theme.colorScheme.onPrimary : color,
        size: 18,
      ),
      backgroundColor: isSelected ? color : theme.colorScheme.surface,
      selectedColor: color,
      side: BorderSide(
        color: isSelected ? Colors.transparent : color,
        width: 1,
      ),
      labelStyle: TextStyle(
        color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
  
  // 構建技能網格
  Widget _buildSkillsGrid(bool isDesktop) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isDesktop ? 3 : (ResponsiveBreakpoints.of(context).isMobile ? 1 : 2),
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: isDesktop ? 1.0 : 0.85,
      ),
      itemCount: _filteredSkills.length,
      itemBuilder: (context, index) {
        return SkillCard(
          skill: _filteredSkills[index],
          index: index,
        );
      },
    ).animate().fadeIn(duration: 600.ms, delay: 400.ms);
  }
  
  // 構建按類別分類的技能部分
  Widget _buildSkillsByCategory(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: SkillCategory.values.map((category) {
        final skills = _skillsByCategory[category] ?? [];
        
        if (skills.isEmpty) {
          return const SizedBox.shrink();
        }
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 類別標題
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: SkillModel.getCategoryColor(category, context).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    SkillModel.getCategoryIcon(category),
                    color: SkillModel.getCategoryColor(category, context),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    SkillModel.getCategoryName(category),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: SkillModel.getCategoryColor(category, context),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 600.ms),
            
            const SizedBox(height: 24),
            
            // 該類別的技能
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isDesktop ? 3 : (ResponsiveBreakpoints.of(context).isMobile ? 1 : 2),
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: isDesktop ? 1.0 : 0.85,
              ),
              itemCount: skills.length,
              itemBuilder: (context, index) {
                return SkillCard(
                  skill: skills[index],
                  index: index,
                );
              },
            ).animate().fadeIn(duration: 600.ms, delay: 100.ms),
            
            const SizedBox(height: 40),
          ],
        );
      }).toList(),
    );
  }
  
  // 構建空狀態提示
  Widget _buildEmptyState(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(48),
      alignment: Alignment.center,
      child: Column(
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: theme.colorScheme.primary.withOpacity(0.5),
          ),
          
          const SizedBox(height: 24),
          
          Text(
            'No matching skills found',
            style: theme.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 16),
          
          Text(
            'Try adjusting your filters or search term',
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 24),
          
          ElevatedButton(
            onPressed: _clearFilters,
            child: const Text('Clear All Filters'),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 300.ms);
  }
}
