import 'package:flutter/material.dart';
import 'package:quiet_study/core/constants/app_constants.dart';
// Removido o import do PrefsService, pois não é mais necessário aqui.

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToOnboarding();
  }

  Future<void> _navigateToOnboarding() async {
    // Espera 2 segundos para mostrar a tela de splash
    await Future.delayed(const Duration(seconds: 2));

    // Navega diretamente para a tela de onboarding, sem verificar nada.
    if (mounted) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.headphones_outlined, size: 80, color: theme.colorScheme.secondary),
            const SizedBox(height: 20),
            Text('QuietStudy', style: theme.textTheme.headlineMedium),
          ],
        ),
      ),
    );
  }
}