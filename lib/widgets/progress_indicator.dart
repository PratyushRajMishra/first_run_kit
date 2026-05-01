import 'package:flutter/material.dart';

/// Linear progress UI showing current step in the flow.
class FirstRunProgressIndicator extends StatelessWidget {
  /// Creates a progress indicator.
  const FirstRunProgressIndicator({
    super.key,
    required this.currentIndex,
    required this.total,
  });

  /// Zero-based index of current step.
  final int currentIndex;

  /// Total number of steps.
  final int total;

  @override
  Widget build(BuildContext context) {
    if (total <= 0) return const SizedBox.shrink();

    final progress = (currentIndex + 1) / total;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Step ${currentIndex + 1} of $total'),
        const SizedBox(height: 8),
        LinearProgressIndicator(value: progress),
      ],
    );
  }
}
