import 'package:flutter/material.dart';
import 'package:quiet_study/core/constants/app_constants.dart';
import 'package:quiet_study/core/services/location_service.dart';
import 'package:quiet_study/core/services/prefs_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _nameController = TextEditingController();
  final LocationService _locationService = LocationService();
  bool _isLoadingLocation = false;

  void _showRevokeConsentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Revogar Consentimento'),
        content: const Text('Você será redirecionado para a tela inicial. Deseja continuar?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancelar')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
            onPressed: () {
              Navigator.of(ctx).pop();
              _revokeConsent(context);
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  void _revokeConsent(BuildContext context) {
    final prefsService = PrefsService();
    prefsService.revokeConsent();
    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.onboarding, (route) => false);
  }

  Future<void> _analyzeLocation() async {
    setState(() {
      _isLoadingLocation = true;
    });

    try {
      final analysis = await _locationService.analyzeCurrentLocation();
      _showAnalysisDialog(analysis);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao analisar localização: ${e.toString()}')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingLocation = false;
        });
      }
    }
  }

  void _showAnalysisDialog(LocationAnalysis analysis) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              analysis.isQuiet ? Icons.check_circle : Icons.warning,
              color: analysis.isQuiet ? Colors.green : Colors.orange,
            ),
            const SizedBox(width: 10),
            Expanded(child: Text(analysis.placeType, overflow: TextOverflow.ellipsis)),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(analysis.recommendation),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  analysis.mapImageUrl,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Text('Não foi possível carregar o mapa.'));
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('FECHAR'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final babyGreenColor = Colors.green.shade200;

    return Scaffold(
      appBar: AppBar(
        title: const Text('QuietStudy'),
        actions: [
          IconButton(
            icon: const Icon(Icons.privacy_tip_outlined),
            onPressed: () => _showRevokeConsentDialog(context),
            tooltip: 'Privacidade e Consentimento',
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Onde você está estudando?',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text(
              'Analise sua localização atual ou adicione um local manualmente.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70),
            ),
            const SizedBox(height: 48),
            if (_isLoadingLocation)
              const Center(child: CircularProgressIndicator())
            else
              OutlinedButton.icon(
                icon: Icon(Icons.my_location, color: babyGreenColor),
                label: Text(
                  'ANALISAR LOCALIZAÇÃO ATUAL',
                  style: TextStyle(color: babyGreenColor, fontWeight: FontWeight.bold),
                ),
                onPressed: _analyzeLocation,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: BorderSide(color: babyGreenColor.withOpacity(0.5), width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            const SizedBox(height: 24),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Ou digite um nome (Ex: Minha casa)',
                prefixIcon: Icon(Icons.edit_location_alt_outlined),
              ),
            ),
          ],
        ),
      ),
    );
  }
}