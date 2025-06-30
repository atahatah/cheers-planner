import 'package:cheers_planner/core/auth/app_auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterScreen extends HookConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final birthday = useState<DateTime?>(null);
    final loading = useState(false);
    return Scaffold(
      appBar: AppBar(title: const Text('ユーザー登録')),
      body: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '生年月日を選択してください',
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton.icon(
                        onPressed: () async {
                          birthday.value = await showDatePicker(
                            context: context,
                            initialDate: birthday.value ?? DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                        },
                        icon: const Icon(Icons.cake),
                        label: Text(
                          birthday.value == null
                              ? '生年月日を選択'
                              : '${birthday.value!.year}/${birthday.value!.month}/${birthday.value!.day}',
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () async {
                          loading.value = true;
                          await ref
                              .read(appAuthControllerProvider.notifier)
                              .register(birthday.value);
                          loading.value = false;
                        },
                        icon: const Icon(Icons.check_circle),
                        label: const Text('Register'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (loading.value) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
