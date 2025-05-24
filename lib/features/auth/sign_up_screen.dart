import 'package:cheers_planner/index.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignUpScreen extends HookConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Sign Up Screen'),
            ElevatedButton(
              onPressed: () => const CounterRoute().go(context),
              child: const Text('Go to Counter'),
            ),
          ],
        ),
      ),
    );
  }
}
