import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quiet_study/core/constants/app_constants.dart';

class ConsentScreen extends StatelessWidget {
  const ConsentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(Icons.shield_outlined, size: 80, color: theme.colorScheme.tertiary),
          const SizedBox(height: 20),
          Text('Consentimento e Privacidade', textAlign: TextAlign.center, style: theme.textTheme.headlineSmall),
          const SizedBox(height: 16),
          Text('Para usar o app, é necessário ler e aceitar nossas políticas.', textAlign: TextAlign.center, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 32),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: theme.textTheme.bodyMedium,
              children: [
                const TextSpan(text: 'Toque aqui para ler a '),
                TextSpan(
                  text: 'Política de Privacidade e os Termos de Uso',
                  style: TextStyle(color: theme.colorScheme.secondary, decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pushNamed(AppRoutes.policyViewer);
                    },
                ),
                const TextSpan(text: '.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}