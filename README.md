# Cheers Planner

## Install
1. `asdf`をインストールしましょう

[こちら](https://asdf-vm.com/ja-jp/guide/getting-started.html)を参考に。

多分みんなMac/Zshだと思うので多分こんな感じ。

brewでインストール
```sh
brew install asdf
```

2. Flutterなどをインストールしましょう
```sh
asdf install
```

3. Firebaseに関するプログラムをインストールしましょう
```sh
npm install -g firebase-tools
```

4. 実行しましょう
VSCodeなら`F5`キーを押せば起動します。
コマンドならこんな感じ
```sh
flutter run -d chrome
```

5. `App Check`を突破しましょう
Geminiとか使うので、セキュリティ高めでいきましょう。
FirebaseのAPIが正しくアプリからアクセスされているかをチェックしてくれるそうです。
[こちら](https://firebase.google.com/docs/app-check/flutter/debug-provider?hl=ja#web)の2, 3を参考にデバッグトークンを登録してください。