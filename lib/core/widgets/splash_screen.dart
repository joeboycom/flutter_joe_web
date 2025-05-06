import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Joe Wu',
              style: theme.textTheme.displaySmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(duration: 800.ms),
            
            const SizedBox(height: 16),
            
            Text(
              'Mobile & Web Developer',
              style: theme.textTheme.titleLarge,
            ).animate().fadeIn(duration: 800.ms, delay: 200.ms),
            
            const SizedBox(height: 32),
            
            CircularProgressIndicator(
              color: theme.colorScheme.primary,
            ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
          ],
        ),
      ),
    );
  }
} 