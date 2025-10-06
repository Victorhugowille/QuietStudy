import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class AppDotsIndicator extends StatelessWidget {
  final int dotsCount;
  final int position;

  const AppDotsIndicator({
    super.key,
    required this.dotsCount,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DotsIndicator(
      dotsCount: dotsCount,
      position: position,
      decorator: DotsDecorator(
        color: Colors.grey,
        activeColor: theme.colorScheme.secondary,
        size: const Size.square(9.0),
        activeSize: const Size(18.0, 9.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }
}