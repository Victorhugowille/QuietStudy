import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:quiet_study/core/constants/app_constants.dart';
import 'package:quiet_study/core/services/prefs_service.dart';

class PolicyViewerScreen extends StatefulWidget {
  const PolicyViewerScreen({super.key});

  @override
  State<PolicyViewerScreen> createState() => _PolicyViewerScreenState();
}

class _PolicyViewerScreenState extends State<PolicyViewerScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _canProceed = false;
  String _privacyData = '';
  String _termsData = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadAllMarkdown();
  }

  Future<void> _loadAllMarkdown() async {
    final privacy = await rootBundle.loadString('assets/policies/privacy_policy.md');
    final terms = await rootBundle.loadString('assets/policies/terms_of_use.md');
    if (mounted) {
      setState(() {
        _privacyData = privacy;
        _termsData = terms;
        _isLoading = false;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) => _checkInitialScroll());
    }
  }

  void _checkInitialScroll() {
    if (mounted && _scrollController.hasClients && _scrollController.position.maxScrollExtent == 0) {
      if (!_canProceed) {
        setState(() {
          _canProceed = true;
        });
      }
    }
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 10) {
      if (!_canProceed) {
        setState(() {
          _canProceed = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Políticas e Termos'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.all(16.0),
              child: SelectionArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MarkdownBody(data: _privacyData),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 24),
                    MarkdownBody(data: _termsData),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _canProceed
              ? () async {
                  await PrefsService().acceptAllPolicies();
                  if (mounted) {
                    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
                  }
                }
              : null,
          child: const Text('IR PARA A TELA INICIAL'),
        ),
      ),
    );
  }
}