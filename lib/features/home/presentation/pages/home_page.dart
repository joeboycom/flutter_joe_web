import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Hero Section
        HeroSection(isDesktop: isDesktop),
        
        const SizedBox(height: 80),
        
        // Featured Projects
        Text(
          'Featured Projects',
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
        
        const SizedBox(height: 32),
        
        FeaturedProjectsCarousel(isDesktop: isDesktop),
        
        const SizedBox(height: 80),
        
        // Call to Action
        CallToAction(isDesktop: isDesktop),
        
        const SizedBox(height: 80),
      ],
    );
  }
}

class HeroSection extends StatelessWidget {
  final bool isDesktop;
  
  const HeroSection({super.key, required this.isDesktop});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isDesktop ? 120 : 64,
        horizontal: 24,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary.withOpacity(0.05),
            theme.colorScheme.secondary.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(isDesktop ? 16 : 0),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title
              Text(
                '10+ Years Mobile & Web Developer',
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(duration: 800.ms).slideY(
                begin: 0.2,
                end: 0,
                curve: Curves.easeOutQuad,
                duration: 800.ms,
              ),
              
              const SizedBox(height: 24),
              
              // Subtitle
              Text(
                'Building Cross-platform Solutions with Flutter & AI',
                style: theme.textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideY(
                begin: 0.2,
                end: 0,
                curve: Curves.easeOutQuad,
                duration: 800.ms,
                delay: 200.ms,
              ),
              
              const SizedBox(height: 32),
              
              // CTA Buttons
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => context.go('/portfolio'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    child: const Text('View Portfolio'),
                  ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
                  
                  OutlinedButton(
                    onPressed: () => context.go('/resume'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    child: const Text('Download Resume'),
                  ).animate().fadeIn(duration: 600.ms, delay: 500.ms),
                  
                  OutlinedButton(
                    onPressed: () => context.go('/contact'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    child: const Text('Contact Me'),
                  ).animate().fadeIn(duration: 600.ms, delay: 600.ms),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeaturedProjectsCarousel extends StatelessWidget {
  final bool isDesktop;
  
  const FeaturedProjectsCarousel({super.key, required this.isDesktop});
  
  @override
  Widget build(BuildContext context) {
    // Sample projects data - in a real app, this would come from a repository
    final projects = [
      {
        'title': 'Flutter E-Commerce App',
        'image': 'assets/images/project1.jpg',
        'description': 'A cross-platform e-commerce application with modern UI/UX.',
        'tags': ['Flutter', 'Firebase', 'Bloc'],
      },
      {
        'title': 'Android Social Media App',
        'image': 'assets/images/project2.jpg',
        'description': 'Native Android social media platform with real-time chat.',
        'tags': ['Kotlin', 'MVVM', 'Jetpack Compose'],
      },
      {
        'title': 'AI Language Learning Tool',
        'image': 'assets/images/project3.jpg',
        'description': 'AI-powered language learning platform with speech recognition.',
        'tags': ['Flutter', 'TensorFlow', 'LLM'],
      },
      {
        'title': 'Web Analytics Dashboard',
        'image': 'assets/images/project4.jpg',
        'description': 'Interactive analytics dashboard with real-time data visualization.',
        'tags': ['Flutter Web', 'GraphQL', 'Riverpod'],
      },
    ];
    
    if (isDesktop) {
      // Desktop view: show multiple cards
      return CarouselSlider(
        options: CarouselOptions(
          height: 400,
          viewportFraction: 0.3,
          enlargeCenterPage: true,
          enableInfiniteScroll: true,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 4),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
        ),
        items: projects.map((project) {
          return Builder(
            builder: (BuildContext context) {
              return ProjectCard(project: project);
            },
          );
        }).toList(),
      ).animate().fadeIn(duration: 800.ms, delay: 400.ms);
    } else {
      // Mobile view: show one card at a time
      return CarouselSlider(
        options: CarouselOptions(
          height: 400,
          enlargeCenterPage: true,
          enableInfiniteScroll: true,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 4),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
        ),
        items: projects.map((project) {
          return Builder(
            builder: (BuildContext context) {
              return ProjectCard(project: project);
            },
          );
        }).toList(),
      ).animate().fadeIn(duration: 800.ms, delay: 400.ms);
    }
  }
}

class ProjectCard extends StatelessWidget {
  final Map<String, dynamic> project;
  
  const ProjectCard({super.key, required this.project});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.go('/portfolio'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Use a placeholder for now - in real app, we would use networkImage
            AspectRatio(
              aspectRatio: 16/9,
              child: Container(
                color: theme.colorScheme.primary.withOpacity(0.2),
                alignment: Alignment.center,
                child: const Icon(Icons.image, size: 48),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    project['title'] as String,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Description
                  Text(
                    project['description'] as String,
                    style: theme.textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Tags
                  Wrap(
                    spacing: 8,
                    children: (project['tags'] as List<String>).map((tag) {
                      return Chip(
                        label: Text(
                          tag,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                        side: BorderSide.none,
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CallToAction extends StatelessWidget {
  final bool isDesktop;
  
  const CallToAction({super.key, required this.isDesktop});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 64,
        horizontal: 24,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.secondary.withOpacity(0.1),
            theme.colorScheme.primary.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            'Ready to work together?',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 600.ms),
          
          const SizedBox(height: 16),
          
          Text(
            "I'm currently available for freelance projects, full-time positions, or consulting.",
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 600.ms, delay: 100.ms),
          
          const SizedBox(height: 32),
          
          ElevatedButton(
            onPressed: () => context.go('/contact'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 48,
                vertical: 20,
              ),
            ),
            child: const Text('Get in Touch'),
          ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
        ],
      ),
    );
  }
} 