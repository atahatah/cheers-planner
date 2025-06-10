# AGENTS.md
このドキュメントは、AI（特にOpenAI Codex）がこのリポジトリのコードを理解し、効果的にコード生成や編集を行うためのガイドラインです。

## プロジェクト概要
このプロジェクトは、FlutterとFirebaseを使用したアプリケーション「Cheers Planner」です。

### 技術スタック
このプロジェクトでは、以下の技術スタックを採用しています。コードを生成・編集する際は、これらの技術と考え方に沿ってください。

#### 全体
- Flutter: UIフレームワークとして使用しています。バージョンは.tool-versionsファイルで管理されています。
  - Riverpod: 状態管理およびDI（Dependency Injection）ライブラリとして使用しています。riverpod_generatorによるコード生成を前提としています。
  - Freezed: イミュータブル（不変）なモデルクラスを作成するために使用しています。
  - GoRouter: 画面遷移を管理するために使用しています。go_router_builderによるコード生成を前提としています。
- Firebase: バックエンドサービスとして使用しています。
  - Authentication: ユーザー認証
  - Firestore: データベース
  - Cloud Functions: サーバーレス関数
  - Cloud Storage: ファイルストレージ
  - App Check: アプリのセキュリティ
#### ディレクトリ構成
- feature-first: 機能ごとにディレクトリを分割するアーキテクチャを採用しています。
新しい機能は flutter/lib/features/ 以下に新しいディレクトリを作成して実装します。
各機能ディレクトリ内には、xxx_screen.dart (画面)、xxx_controller.dart (ロジック)、xxx_repo.dart (データアクセス) などを配置します。
- core: アプリ全体で共通して利用する機能（認証、ルーティング、共通コンポーネントなど）は flutter/lib/core/ 以下に配置します。
## コーディング規約
- 状態管理: Riverpodを使用します。UIコンポーネントはHookConsumerWidgetを継承し、状態の変更はController経由で行います。
- モデルクラス: Freezedを使用して、イミュータブルなクラスを定義します。
- ビルド: build_runnerを使用して、*.g.dartや*.freezed.dartなどのファイルを自動生成します。これらのファイルは直接編集しないでください。
- Firebaseとの連携:
- Firestore: withConverterを使用して、型安全なデータのやり取りを行います。
- 認証: FirebaseUI (firebase_ui_auth) を使用しています。
## AIへの指示（プロンプトの例）
### 新機能の追加
「featuresディレクトリにplanningという名前で新しい機能を追加してください。planning_screen.dart、planning_controller.dart、planning_repo.dartを作成し、GoRouterの設定に新しいルートを追加してください。」

### Riverpod Providerの作成
「features/counter/counter_controller.dart のような形で、新しいControllerを作成してください。@riverpodアノテーションを使い、状態としてintを保持し、それをインクリメントするメソッドを実装してください。」

### Freezedモデルの作成
「UserEntryモデル(flutter/lib/core/auth/user_entry.dart)を参考に、新しいEventモデルを作成してください。id, name, dateのフィールドを持たせてください。dateはDateTime型で、FirestoreのTimestampと相互変換できるようにしてください。」

## 注意点
Freezed 3系: このプロジェクトではFreezedの3系を使用しています。AIはまだこのバージョンに詳しくない可能性があるため、生成されたコードがsealed classかabstract classを使用しているか確認してください。

自動生成ファイル: *.g.dartや*.freezed.dartで終わるファイルは、flutter pub run build_runner buildコマンドで自動生成されます。これらのファイルを直接編集するような指示は避けてください。

## Test
Flutterアプリに関して正しくコーディングができているか、次の手順で調べてください。
```sh
cd flutter
# コード自動生成
flutter pub run build_runner build --delete-conflicting-outputs
# ビルド
flutter build web
```