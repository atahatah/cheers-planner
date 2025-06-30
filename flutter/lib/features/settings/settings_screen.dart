import 'package:cheers_planner/core/app/snackbar_repo.dart';
import 'package:cheers_planner/core/auth/app_auth_controller.dart';
import 'package:cheers_planner/core/firebase/auth_repo.dart';
import 'package:cheers_planner/features/settings/test_data_repo.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('設定')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'アカウント',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'アプリにログイン中です。',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.data_array,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'テストデータ',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'テスト用のサンプルデータを作成できます。',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: () async {
                        try {
                          final uid = ref.read(requireUserProvider).uid;
                          await ref
                              .read(testDataRepoProvider)
                              .createWelcomePartyData(uid);
                          ref
                              .read(snackBarRepoProvider)
                              .show('新人歓迎会のテストデータを作成しました');
                        } catch (e) {
                          ref
                              .read(snackBarRepoProvider)
                              .show('テストデータの作成に失敗しました');
                        }
                      },
                      icon: const Icon(Icons.celebration),
                      label: const Text('新人歓迎会のテストデータを作成'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                ref.read(appAuthControllerProvider.notifier).signOut();
              },
              icon: const Icon(Icons.logout),
              label: const Text('サインアウト'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
