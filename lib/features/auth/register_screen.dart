import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterScreen extends HookConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final birthday = useState<DateTime?>(null);
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Center(
        child: Column(
          children: [
            if (birthday.value != null)
              Text('Selected Birthday: ${birthday.value!.toLocal()}')
            else
              const Text('No Birthday Selected'),
            ElevatedButton(
              onPressed: () {
                // Handle registration logic here
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
