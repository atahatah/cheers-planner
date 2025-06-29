import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VotedListScreen extends HookConsumerWidget {
  const VotedListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Voted List')),
      body: const Center(child: Text('Voted List Screen')),
    );
  }
}
