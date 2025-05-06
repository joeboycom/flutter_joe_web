import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_joe_web/core/theme/app_theme.dart';
import 'package:flutter_joe_web/features/home/presentation/pages/home_page.dart';
import 'package:flutter_joe_web/features/portfolio/presentation/pages/portfolio_page.dart';
import 'package:flutter_joe_web/features/about/presentation/pages/about_page.dart';
import 'package:flutter_joe_web/features/skills/presentation/pages/skills_page.dart';
import 'package:flutter_joe_web/features/achievements/presentation/pages/achievements_page.dart';
import 'package:flutter_joe_web/features/contact/presentation/pages/contact_page.dart';
import 'package:flutter_joe_web/features/resume/presentation/pages/resume_page.dart';
import 'package:flutter_joe_web/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter_joe_web/features/opensource/presentation/pages/opensource_page.dart';
import 'package:flutter_joe_web/core/widgets/main_scaffold.dart';
import 'package:flutter_joe_web/core/widgets/splash_screen.dart';
import 'package:flutter_joe_web/core/config/env.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize environment variables
  await Env.init();
  
  // Remove # from URL
  setPathUrlStrategy();
  
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/portfolio',
          builder: (context, state) => const PortfolioPage(),
        ),
        GoRoute(
          path: '/about',
          builder: (context, state) => const AboutPage(),
        ),
        GoRoute(
          path: '/skills',
          builder: (context, state) => const SkillsPage(),
        ),
        GoRoute(
          path: '/achievements',
          builder: (context, state) => const AchievementsPage(),
        ),
        GoRoute(
          path: '/blog',
          builder: (context, state) => const BlogPage(),
        ),
        GoRoute(
          path: '/opensource',
          builder: (context, state) => const OpenSourcePage(),
        ),
        GoRoute(
          path: '/contact',
          builder: (context, state) => const ContactPage(),
        ),
        GoRoute(
          path: '/resume',
          builder: (context, state) => const ResumePage(),
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: Env.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: _router,
      builder: (context, child) {
        return ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: const [
            Breakpoint(start: 0, end: 450, name: MOBILE),
            Breakpoint(start: 451, end: 800, name: TABLET),
            Breakpoint(start: 801, end: 1920, name: DESKTOP),
            Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        );
      },
    );
  }
}
