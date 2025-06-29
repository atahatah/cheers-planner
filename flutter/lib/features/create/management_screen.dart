import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ManagementScreen extends HookConsumerWidget {
  const ManagementScreen({super.key, required this.eventId});
  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Management')),
      body: const Center(child: Text('Management Screen')),
    );
  }
}
