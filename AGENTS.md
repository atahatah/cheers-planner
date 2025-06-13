# AGENTS.md
このドキュメントは、OpenAI Codex がこのリポジトリで作業するときに従うべきルールをまとめたものです。プロジェクトの理解と効率的なタスク実行に役立ててください。

## プロジェクト概要
Flutter と Firebase を利用した **Cheers Planner** というアプリケーションのコードです。Riverpod、Freezed、GoRouter などを採用しています。

### 技術スタック
- **Flutter**：バージョンは `.tool-versions` に記載。UI 構築に使用します。
  - **Riverpod**：状態管理および DI。`riverpod_generator` を利用します。
  - **Freezed**：イミュータブルなモデル生成に使用します。
  - **GoRouter**：画面遷移を管理し、`go_router_builder` でコード生成します。
- **Firebase**：Authentication、Firestore、Cloud Functions、Storage、App Check などを利用します。

### ディレクトリ構成
- `flutter/lib/features/`：機能ごとにディレクトリを作成し、`xxx_screen.dart`、`xxx_controller.dart`、`xxx_repo.dart` などを配置します。
- `flutter/lib/core/`：認証や共通コンポーネントなど、アプリ全体で使うコードをまとめます。

## コーディング規約
1. **状態管理**：UI コンポーネントは `HookConsumerWidget` を継承し、状態変更は Controller 経由で行います。
2. **モデル定義**：`Freezed` を使って `*.g.dart` と `*.freezed.dart` を自動生成します。これらのファイルは手動で編集しません。
3. **Firestore 連携**：`withConverter` を用いて型安全なデータ操作を行います。
4. **テスト・フォーマット手順**：
   コーディング後からコミット前までに、次のコマンドでコードを整えてください。
```sh
cd flutter
flutter pub run build_runner build --delete-conflicting-outputs # コード生成
flutter analyze || flutter fix --apply # lint
dart format . # フォーマット
```

   コミット前にはフォーマットチェックとビルド確認を行います。
```sh
cd flutter
flutter analyze # lint
dart format . --set-exit-if-changed # 正しくフォーマットができているか確認
flutter build web # ビルドが通るか確認
```

## Git 運用
- **ブランチ名**：英語で記述すること。
- **コミットメッセージ**：日本語で簡潔にまとめること。
- **プルリクエスト**：タイトル・本文とも日本語で記載し、変更点と確認方法を明記すること。

## AI への指示例
- 新機能追加時は `flutter/lib/features/<name>/` に必要なファイルを作成し、`GoRouter` のルートも更新してください。
- Provider を定義する際は `@riverpod` アノテーションを使用し、必要に応じて `freezed` と組み合わせてください。
- モデル追加時は `flutter/lib/core/auth/user_entry.dart` を参考に、`fromJson`/`toJson` で `Timestamp` 変換を実装してください。

## 注意点
- `Freezed` 3 系を使用しているため、生成クラスが `sealed class` または `abstract class` になっているか確認してください。
- `flutter/.env.example` をコピーして `.env` を作成し、必要な環境変数を設定します。
- Firebase 本番環境へのアクセスは控え、基本はエミュレーターを使用します。`firebase emulators:start` で起動可能です。


