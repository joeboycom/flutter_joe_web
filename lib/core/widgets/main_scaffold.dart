import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBreakpoints.builder(
        breakpoints: const [
          Breakpoint(start: 0, end: 450, name: MOBILE),
          Breakpoint(start: 451, end: 800, name: TABLET),
          Breakpoint(start: 801, end: 1920, name: DESKTOP),
          Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
        child: ResponsiveScaffold(
          child: child,
        ),
      ),
    );
  }
}

class ResponsiveScaffold extends StatelessWidget {
  final Widget child;

  const ResponsiveScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);

    return Column(
      children: [
        // Header
        if (isDesktop)
          DesktopHeader()
        else
          MobileHeader(),

        // Main content
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Content
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: child,
                  ),
                ),

                // Footer
                const Footer(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DesktopHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentPath = GoRouterState.of(context).uri.path;

    return Container(
      color: theme.colorScheme.surface,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo
              Text(
                'Joe Wu',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),

              // Navigation links
              Row(
                children: [
                  _buildNavLink(context, 'Home', '/', currentPath),
                  _buildNavLink(context, 'Portfolio', '/portfolio', currentPath),
                  _buildNavLink(context, 'About', '/about', currentPath),
                  _buildNavLink(context, 'Skills', '/skills', currentPath),
                  _buildNavLink(context, 'Achievements', '/achievements', currentPath),
                  _buildNavLink(context, 'Blog', '/blog', currentPath),
                  _buildNavLink(context, 'Open Source', '/opensource', currentPath),
                  _buildNavLink(context, 'Contact', '/contact', currentPath),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => context.go('/resume'),
                    child: const Text('Resume'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavLink(BuildContext context, String title, String path, String currentPath) {
    final theme = Theme.of(context);
    final isActive = currentPath == path;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: TextButton(
        onPressed: () => context.go(path),
        style: TextButton.styleFrom(
          foregroundColor: isActive ? theme.colorScheme.primary : theme.colorScheme.onSurface,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ),
        child: Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            decoration: isActive ? TextDecoration.underline : TextDecoration.none,
            decorationThickness: 2,
          ),
        ),
      ),
    );
  }
}

class MobileHeader extends StatefulWidget {
  @override
  State<MobileHeader> createState() => _MobileHeaderState();
}

class _MobileHeaderState extends State<MobileHeader> {
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.surface,
      child: Column(
        children: [
          // AppBar with menu button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo
                Text(
                  'Joe Wu',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),

                // Menu button
                IconButton(
                  icon: Icon(_isMenuOpen ? Icons.close : Icons.menu),
                  onPressed: () {
                    setState(() {
                      _isMenuOpen = !_isMenuOpen;
                    });
                  },
                ),
              ],
            ),
          ),

          // Expandable menu
          if (_isMenuOpen)
            _buildMobileMenu(context),
        ],
      ),
    );
  }

  Widget _buildMobileMenu(BuildContext context) {
    final theme = Theme.of(context);
    final currentPath = GoRouterState.of(context).uri.path;

    return Container(
      width: double.infinity,
      color: theme.colorScheme.surface,
      child: Column(
        children: [
          _buildMobileNavLink(context, 'Home', '/', currentPath),
          _buildMobileNavLink(context, 'Portfolio', '/portfolio', currentPath),
          _buildMobileNavLink(context, 'About', '/about', currentPath),
          _buildMobileNavLink(context, 'Skills', '/skills', currentPath),
          _buildMobileNavLink(context, 'Achievements', '/achievements', currentPath),
          _buildMobileNavLink(context, 'Blog', '/blog', currentPath),
          _buildMobileNavLink(context, 'Open Source', '/opensource', currentPath),
          _buildMobileNavLink(context, 'Contact', '/contact', currentPath),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                context.go('/resume');
                setState(() {
                  _isMenuOpen = false;
                });
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Resume'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileNavLink(BuildContext context, String title, String path, String currentPath) {
    final theme = Theme.of(context);
    final isActive = currentPath == path;

    return InkWell(
      onTap: () {
        context.go(path);
        setState(() {
          _isMenuOpen = false;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: theme.dividerTheme.color ?? Colors.grey.shade300,
              width: 1,
            ),
          ),
          color: isActive ? theme.colorScheme.primary.withOpacity(0.1) : null,
        ),
        child: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? theme.colorScheme.primary : theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);

    return Container(
      color: theme.colorScheme.surface,
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Column(
          children: [
            if (isDesktop)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Brand and bio
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Joe Wu',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Mobile & Web Developer with 10+ years of experience. '
                          'Specialized in Flutter, Android, and Web development.',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),

                  // Quick links
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quick Links',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildFooterLink(context, 'Home', '/'),
                        _buildFooterLink(context, 'Portfolio', '/portfolio'),
                        _buildFooterLink(context, 'About', '/about'),
                        _buildFooterLink(context, 'Contact', '/contact'),
                      ],
                    ),
                  ),

                  // Social links
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Connect',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildSocialLink(context, 'GitHub', FontAwesomeIcons.github, 'https://github.com'),
                        _buildSocialLink(context, 'LinkedIn', FontAwesomeIcons.linkedin, 'https://linkedin.com'),
                        _buildSocialLink(context, 'Twitter', FontAwesomeIcons.twitter, 'https://twitter.com'),
                        _buildSocialLink(context, 'Email', FontAwesomeIcons.envelope, 'mailto:contact@example.com'),
                      ],
                    ),
                  ),
                ],
              )
            else
              Column(
                children: [
                  // Brand and bio
                  Text(
                    'Joe Wu',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Mobile & Web Developer with 10+ years of experience. '
                    'Specialized in Flutter, Android, and Web development.',
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  // Social icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialIcon(context, FontAwesomeIcons.github, 'https://github.com'),
                      const SizedBox(width: 24),
                      _buildSocialIcon(context, FontAwesomeIcons.linkedin, 'https://linkedin.com'),
                      const SizedBox(width: 24),
                      _buildSocialIcon(context, FontAwesomeIcons.twitter, 'https://twitter.com'),
                      const SizedBox(width: 24),
                      _buildSocialIcon(context, FontAwesomeIcons.envelope, 'mailto:contact@example.com'),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),

            // Copyright
            const Divider(),
            const SizedBox(height: 16),
            Text(
              '© ${DateTime.now().year} Joe Wu. All rights reserved.',
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterLink(BuildContext context, String title, String path) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () => context.go(path),
        child: Text(
          title,
          style: theme.textTheme.bodyMedium,
        ),
      ),
    );
  }

  Widget _buildSocialLink(BuildContext context, String title, IconData icon, String url) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () {
          // TODO: Implement URL launcher
        },
        child: Row(
          children: [
            FaIcon(icon, size: 16),
            const SizedBox(width: 8),
            Text(
              title,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIcon(BuildContext context, IconData icon, String url) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        // TODO: Implement URL launcher
      },
      child: FaIcon(
        icon,
        size: 24,
        color: theme.colorScheme.primary,
      ),
    );
  }
} 