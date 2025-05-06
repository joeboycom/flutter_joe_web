import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 頁面標題
            Text(
              'About Me',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(duration: 600.ms),
            
            const SizedBox(height: 40),
            
            // 個人簡介和照片區
            BioSection(isDesktop: isDesktop),
            
            const SizedBox(height: 64),
            
            // 專業時間軸
            const TimelineSection(),
            
            const SizedBox(height: 64),
            
            // 興趣與社群貢獻
            const InterestsSection(),
          ],
        ),
      ),
    );
  }
}

class BioSection extends StatelessWidget {
  final bool isDesktop;
  
  const BioSection({super.key, required this.isDesktop});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return isDesktop
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 個人簡介
              Expanded(
                flex: 3,
                child: _buildBioContent(context),
              ),
              
              const SizedBox(width: 48),
              
              // 個人照片
              Expanded(
                flex: 2,
                child: _buildPhotoSection(theme),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 個人簡介
              _buildBioContent(context),
              
              const SizedBox(height: 32),
              
              // 個人照片
              _buildPhotoSection(theme),
            ],
          );
  }
  
  Widget _buildBioContent(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Who I Am',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 100.ms),
        
        const SizedBox(height: 24),
        
        Text(
          'Joe Wu is a seasoned mobile and web developer with over 10 years of experience creating cutting-edge applications and solutions. Specializing in Flutter, Android, and web development, Joe has built a reputation for delivering high-quality, performant, and user-friendly products.',
          style: theme.textTheme.bodyLarge,
        ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
        
        const SizedBox(height: 16),
        
        Text(
          'With a strong foundation in both native and cross-platform development, Joe has helped numerous companies bring their digital products to life across multiple platforms. His expertise extends beyond coding to product strategy, UI/UX design principles, and team leadership, allowing him to contribute value at every stage of the development process.',
          style: theme.textTheme.bodyLarge,
        ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
        
        const SizedBox(height: 32),
        
        // 專業關鍵詞
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildKeywordChip(context, 'Flutter Expert'),
            _buildKeywordChip(context, 'Mobile Development'),
            _buildKeywordChip(context, 'Web Applications'),
            _buildKeywordChip(context, 'UI/UX Design'),
            _buildKeywordChip(context, 'System Architecture'),
            _buildKeywordChip(context, 'Team Leadership'),
          ],
        ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
      ],
    );
  }
  
  Widget _buildPhotoSection(ThemeData theme) {
    return Column(
      children: [
        // 主要專業照片
        Container(
          height: 300,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.person,
            size: 120,
            color: theme.colorScheme.primary.withOpacity(0.7),
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
        
        const SizedBox(height: 16),
        
        // 其他照片
        Row(
          children: [
            // 演講照片
            Expanded(
              child: Container(
                height: 140,
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.mic,
                  size: 48,
                  color: theme.colorScheme.secondary.withOpacity(0.7),
                ),
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
            
            const SizedBox(width: 16),
            
            // 日常工作照片
            Expanded(
              child: Container(
                height: 140,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.laptop,
                  size: 48,
                  color: theme.colorScheme.primary.withOpacity(0.7),
                ),
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // 圖片說明
        Text(
          'Photo: Professional headshot (top), Speaking at Flutter Conference (bottom left), Working on a project (bottom right)',
          style: theme.textTheme.bodySmall,
          textAlign: TextAlign.center,
        ).animate().fadeIn(duration: 600.ms, delay: 500.ms),
      ],
    );
  }
  
  Widget _buildKeywordChip(BuildContext context, String label) {
    final theme = Theme.of(context);
    
    return Chip(
      label: Text(
        label,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: theme.colorScheme.primary,
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}

class TimelineSection extends StatelessWidget {
  const TimelineSection({super.key});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // 時間軸事件數據 - 實際應用中可能從數據源獲取
    final timelineEvents = [
      {
        'year': '2023',
        'title': 'Senior Flutter Architect',
        'company': 'TechInnovate Inc.',
        'description': 'Leading development of enterprise Flutter applications across mobile and web platforms. Implementing advanced state management patterns and establishing Flutter best practices.'
      },
      {
        'year': '2020',
        'title': 'Flutter Development Lead',
        'company': 'MobileFirst Solutions',
        'description': 'Transitioned company products from native to cross-platform Flutter development. Reduced development time by 40% while maintaining high-quality user experiences.'
      },
      {
        'year': '2017',
        'title': 'Senior Android Developer',
        'company': 'AppCreators Tech',
        'description': 'Developed Android applications with Kotlin, utilized MVVM architecture, and implemented Jetpack components. Created maintainable, testable code for millions of users.'
      },
      {
        'year': '2014',
        'title': 'Mobile Developer',
        'company': 'Digital Innovations',
        'description': 'Built native Android applications using Java. Worked with RESTful APIs, SQLite databases, and implemented Material Design principles.'
      },
      {
        'year': '2012',
        'title': 'Junior Developer',
        'company': 'StartTech Studios',
        'description': 'Started career developing mobile applications and responsive websites. Gained foundations in Java, JavaScript, and UI/UX design principles.'
      },
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Professional Journey',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ).animate().fadeIn(duration: 600.ms),
        
        const SizedBox(height: 32),
        
        // 時間軸事件列表
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: timelineEvents.length,
          itemBuilder: (context, index) {
            final event = timelineEvents[index];
            final isLast = index == timelineEvents.length - 1;
            
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 年份
                SizedBox(
                  width: 80,
                  child: Text(
                    event['year'] as String,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                
                // 時間軸線
                Column(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    if (!isLast)
                      Container(
                        width: 2,
                        height: 100,
                        color: theme.colorScheme.primary.withOpacity(0.5),
                      ),
                  ],
                ),
                
                const SizedBox(width: 16),
                
                // 事件內容
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event['title'] as String,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      Text(
                        event['company'] as String,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      
                      const SizedBox(height: 8),
                      
                      Text(
                        event['description'] as String,
                        style: theme.textTheme.bodyMedium,
                      ),
                      
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ).animate().fadeIn(duration: 600.ms, delay: Duration(milliseconds: 100 * index));
          },
        ),
      ],
    );
  }
}

class InterestsSection extends StatelessWidget {
  const InterestsSection({super.key});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    
    // 興趣和社群貢獻數據
    final interests = [
      {
        'icon': FontAwesomeIcons.code,
        'title': 'Open Source',
        'description': 'Active contributor to Flutter packages and plugins. Maintains several open-source libraries with thousands of users.'
      },
      {
        'icon': FontAwesomeIcons.userGroup,
        'title': 'Community',
        'description': 'Organizes local Flutter meetups and workshops. Mentors new developers entering the field of mobile development.'
      },
      {
        'icon': FontAwesomeIcons.microphone,
        'title': 'Speaking',
        'description': 'Regular speaker at technology conferences on topics related to Flutter, cross-platform development, and mobile UX design.'
      },
      {
        'icon': FontAwesomeIcons.bookOpen,
        'title': 'Writing',
        'description': 'Writes technical articles and tutorials on Medium and personal blog. Has published guides on state management and performance optimization.'
      },
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Interests & Community',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ).animate().fadeIn(duration: 600.ms),
        
        const SizedBox(height: 32),
        
        // 興趣和社群貢獻卡片
        isDesktop
            ? GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: 2,
                ),
                itemCount: interests.length,
                itemBuilder: (context, index) {
                  final interest = interests[index];
                  return _buildInterestCard(context, interest, index);
                },
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: interests.length,
                itemBuilder: (context, index) {
                  final interest = interests[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: _buildInterestCard(context, interest, index),
                  );
                },
              ),
        
        const SizedBox(height: 48),
        
        // 座右銘
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary.withOpacity(0.1),
                theme.colorScheme.secondary.withOpacity(0.1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              const Icon(
                Icons.format_quote,
                size: 40,
              ),
              
              const SizedBox(height: 16),
              
              Text(
                '"Good design is as little design as possible. Less, but better - because it concentrates on the essential aspects, and the products are not burdened with non-essentials."',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 16),
              
              Text(
                '- Dieter Rams',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ).animate().fadeIn(duration: 800.ms),
      ],
    );
  }
  
  Widget _buildInterestCard(BuildContext context, Map<String, dynamic> interest, int index) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: FaIcon(
                interest['icon'] as IconData,
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
                    interest['title'] as String,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    interest['description'] as String,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: Duration(milliseconds: 100 * index));
  }
}
