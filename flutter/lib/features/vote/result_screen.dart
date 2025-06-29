import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResultScreen extends HookConsumerWidget {
  const ResultScreen({super.key, required this.eventId});
  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('投票結果')),
      body: const Center(child: Text('投票結果をお待ちください。')),
    );
  }
}
