import 'package:components/components.dart';
import 'package:flutter/material.dart';

class LoadingFailed extends StatelessWidget {
  const LoadingFailed({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'Oops, loading failed.',
            style: context.textTheme.displaySmall,
          ),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
          const SizedBox(height: 64),
        ],
      ),
    );
  }
}
