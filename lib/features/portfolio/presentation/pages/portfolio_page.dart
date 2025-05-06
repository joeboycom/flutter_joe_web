import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_joe_web/features/portfolio/presentation/models/project_model.dart';
import 'package:flutter_joe_web/features/portfolio/presentation/widgets/project_card.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  // 選擇的類別篩選
  Set<ProjectCategory> _selectedCategories = {};
  
  // 項目列表
  late List<ProjectModel> _projects;
  late List<ProjectModel> _filteredProjects;
  
  // 搜索關鍵詞
  String _searchQuery = '';
  
  // 搜索控制器
  final TextEditingController _searchController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    
    // 初始化項目數據
    _projects = ProjectModel.getSampleProjects();
    _filteredProjects = List.from(_projects);
    
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
      _filterProjects();
    });
  }
  
  // 切換類別篩選
  void _toggleCategory(ProjectCategory category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category);
      } else {
        _selectedCategories.add(category);
      }
      _filterProjects();
    });
  }
  
  // 清除所有篩選條件
  void _clearFilters() {
    setState(() {
      _selectedCategories.clear();
      _searchController.clear();
      _searchQuery = '';
      _filteredProjects = List.from(_projects);
    });
  }
  
  // 根據篩選條件篩選項目
  void _filterProjects() {
    setState(() {
      if (_selectedCategories.isEmpty && _searchQuery.isEmpty) {
        // 無篩選條件，顯示所有項目
        _filteredProjects = List.from(_projects);
      } else {
        // 應用篩選條件
        _filteredProjects = _projects.where((project) {
          // 檢查類別篩選
          bool matchesCategory = _selectedCategories.isEmpty || 
              project.categories.any((category) => _selectedCategories.contains(category));
          
          // 檢查搜索關鍵詞
          bool matchesSearch = _searchQuery.isEmpty || 
              project.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              project.description.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              project.technologies.any((tech) => tech.toLowerCase().contains(_searchQuery.toLowerCase()));
          
          return matchesCategory && matchesSearch;
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
              'Portfolio',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(duration: 600.ms),
            
            const SizedBox(height: 16),
            
            // 項目簡介
            Text(
              'Explore my featured projects across mobile, web, AI, and open source development. Each project showcases different skills and technologies.',
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
                    'Filter Projects',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // 搜索框
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by name, description, or technology...',
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
                  
                  // 類別篩選器
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      // 所有類別篩選按鈕
                      _buildCategoryFilterChip(
                        context,
                        ProjectCategory.mobile,
                        'Mobile',
                        Icons.smartphone,
                      ),
                      _buildCategoryFilterChip(
                        context,
                        ProjectCategory.web,
                        'Web',
                        Icons.web,
                      ),
                      _buildCategoryFilterChip(
                        context,
                        ProjectCategory.ai,
                        'AI/LLM',
                        Icons.psychology,
                      ),
                      _buildCategoryFilterChip(
                        context,
                        ProjectCategory.openSource,
                        'Open Source',
                        Icons.code,
                      ),
                      
                      // 清除篩選按鈕
                      if (_selectedCategories.isNotEmpty || _searchQuery.isNotEmpty)
                        FilterChip(
                          label: const Text('Clear All'),
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
              'Showing ${_filteredProjects.length} of ${_projects.length} projects',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
            
            const SizedBox(height: 24),
            
            // 項目網格
            _filteredProjects.isEmpty
                ? _buildEmptyState(theme)
                : _buildProjectGrid(isDesktop),
          ],
        ),
      ),
    );
  }
  
  // 構建類別篩選芯片
  Widget _buildCategoryFilterChip(
    BuildContext context,
    ProjectCategory category,
    String label,
    IconData icon,
  ) {
    final theme = Theme.of(context);
    final isSelected = _selectedCategories.contains(category);
    final color = ProjectModel.getCategoryColor(category, context);
    
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
  
  // 構建項目網格
  Widget _buildProjectGrid(bool isDesktop) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isDesktop ? 3 : (ResponsiveBreakpoints.of(context).isMobile ? 1 : 2),
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 0.75,
      ),
      itemCount: _filteredProjects.length,
      itemBuilder: (context, index) {
        return ProjectCard(
          project: _filteredProjects[index],
          index: index,
        );
      },
    ).animate().fadeIn(duration: 600.ms, delay: 400.ms);
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
            'No matching projects found',
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
