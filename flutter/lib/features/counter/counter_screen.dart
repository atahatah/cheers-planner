import 'package:cheers_planner/index.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// これが画面の設定になります。
// 画面の更新が必要な場合はStateful Widgetを使うのが基本ですが、
// Riverpod/Hooksを使うことで、より簡潔に便利に書くことができます。
// そのため、画面は必ずHookConsumerWidgetを継承するようにします。
class CounterScreen extends HookConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 画面の状態を取得するために、Providerを使います。
    final counterState = ref.watch(counterControllerProvider);
    // 必ずScaffoldがトップレベルに必要です。
    // Scaffoldは画面の基本的なレイアウトを提供します。
    return Scaffold(
      appBar: AppBar(
        // 色はできるだけThemeを使うようにします。
        // これにより、アプリ全体で一貫したデザインが保たれます。
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Counter Sample'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            // 文字の大きさはThemeを使うことで、
            // アプリ全体で一貫したデザインが保たれます。
            Text(
              '$counterState',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Riverpodのメソッドを呼び出す時は必ずnotifierを使います。
        // notifierを使えばProviderの状態が更新されても画面の更新はされません。
        onPressed: () =>
            ref.read(counterControllerProvider.notifier).increment(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
