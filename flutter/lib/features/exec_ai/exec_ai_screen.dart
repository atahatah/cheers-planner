import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExecAiScreen extends HookConsumerWidget {
  const ExecAiScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Execution'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'AI Execution Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            _ExecuteAiButton(),
          ],
        ),
      ),
    );
  }
}

class _ExecuteAiButton extends StatelessWidget {
  const _ExecuteAiButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // TODO: AI実行処理を実装
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('AI実行処理を実装予定'),
            duration: Duration(seconds: 2),
          ),
        );
      },
      icon: const Icon(Icons.smart_toy),
      label: const Text('Execute AI'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        textStyle: const TextStyle(fontSize: 18),
      ),
    );
  }
}
