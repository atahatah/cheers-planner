import 'package:cheers_planner/core/auth/index.dart';
import 'package:cheers_planner/core/firebase/firebase_ai_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final generativeAIModel = ref.watch(generativeAIModelProvider);
    final isGeminiEchoMock = ref.watch(isGeminiEchoMockProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: Column(
          children: [
            const Text('Gemini Settings'),
            SwitchListTile(
              title: const Text('Gemini Echo Mock'),
              value: isGeminiEchoMock,
              onChanged: (value) =>
                  ref.read(isGeminiEchoMockProvider.notifier).set(value),
            ),
            if (!isGeminiEchoMock)
              DropdownButton<GenerativeAIModels>(
                value: generativeAIModel,
                items: GenerativeAIModels.values.map((model) {
                  return DropdownMenuItem(
                    value: model,
                    child: Text(model.displayName),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    ref.read(generativeAIModelProvider.notifier).set(value);
                  }
                },
              ),
            const Text('test'),
            ElevatedButton(
              onPressed: () {
                // これはfirestoreに繋がるかサックとテストするようなので
                // 真面目に実装していない
                FirebaseFirestore.instance.doc('test/test').set({
                  'field': FieldValue.serverTimestamp(),
                });
              },
              child: const Text('firestore test'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.watch(appAuthControllerProvider.notifier).signOut();
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
