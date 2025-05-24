import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Settings Screen'),
            ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance.doc('test/test').set({
                  'field': FieldValue.serverTimestamp(),
                });
              },
              child: const Text('firestore test'),
            ),
          ],
        ),
      ),
    );
  }
}
