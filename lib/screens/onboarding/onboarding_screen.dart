import 'package:flutter/material.dart';
import 'package:quiet_study/screens/consent/consent_screen.dart';
import 'package:quiet_study/widgets/dots_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _pages = [
    _buildPage(
      icon: Icons.search,
      title: "Encontre o Silêncio",
      description: "Descubra e registre locais perfeitos para se concentrar.",
    ),
    _buildPage(
      icon: Icons.rate_review_outlined,
      title: "Avalie e Contribua",
      description: "Ajude a comunidade a encontrar os melhores ambientes.",
    ),
    const ConsentScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    bool isLastPage = _currentPage == _pages.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) => setState(() => _currentPage = page),
                children: _pages,
              ),
            ),
            if (!isLastPage) _buildNavigationControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationControls() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () => _pageController.animateToPage(
              _pages.length - 1,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            ),
            child: const Text("PULAR"),
          ),
          AppDotsIndicator(
            dotsCount: _pages.length - 1,
            position: _currentPage,
          ),
          ElevatedButton(
            onPressed: () => _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            ),
            child: const Text("AVANÇAR"),
          ),
        ],
      ),
    );
  }
}

Widget _buildPage({
  required IconData icon,
  required String title,
  required String description,
}) {
  return Builder(builder: (context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 100, color: theme.colorScheme.secondary),
          const SizedBox(height: 40),
          Text(title, style: theme.textTheme.headlineSmall),
          const SizedBox(height: 16),
          Text(
            description,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  });
}