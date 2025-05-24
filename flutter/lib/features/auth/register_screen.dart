import 'package:cheers_planner/index.dart';
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
      appBar: AppBar(title: const Text('Register')),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                if (birthday.value != null)
                  Text('Selected Birthday: ${birthday.value!.toLocal()}')
                else
                  const Text('No Birthday Selected'),
                ElevatedButton(
                  onPressed: () async {
                    birthday.value = await showDatePicker(
                      context: context,
                      initialDate: birthday.value ?? DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                  },
                  child: const Text('Select Birthday'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    loading.value = true;
                    await ref
                        .read(appAuthControllerProvider.notifier)
                        .register(birthday.value);
                    loading.value = false;
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
            if (loading.value) const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
