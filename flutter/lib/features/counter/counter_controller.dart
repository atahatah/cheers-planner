import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'counter_controller.g.dart';

// ここでは、画面の状態を管理するためにProviderを使います。
// Riverpodを使うことで、状態管理が簡単に行えます。
// Riverpodでは状態の保持と更新をすることができます。
@riverpod
class CounterController extends _$CounterController {
  // 初期値を設定します。
  @override
  int build() {
    return 0;
  }

  // 状態を更新するためのメソッドを定義します。
  void increment() {
    // stateを更新することで、ref.watch()を使っている
    // 画面や他のProviderに通知が行われます。
    // これにより、画面が再描画されます。
    state++;
  }

  void decrement() {
    state--;
  }
}
