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
ただ、まだサインインはできません。

5. `App Check`を突破しましょう

Geminiとか使うので、セキュリティ高めでいきましょう。
FirebaseのAPIが正しくアプリからアクセスされているかをチェックしてくれるそうです。

まずはプログラムを起動させてください。
そして、URLの末尾に`?firstIssue=true`をつけてロードしなおしてください。

その後、`F12`を押すなどして開発者モードを開き、`Console`開いてください。
そこに、tokenの情報があるはずなので、それをコピーしてください。

Firebase コンソールの [App Check](https://console.firebase.google.com/project/cheers-planner/appcheck/apps?hl=ja) セクションで、アプリのオーバーフロー メニューから [デバッグ トークンを管理] を選択します。前の手順でロギングされたデバッグ トークンを登録します。

次回以降も同様のトークンが使えるように`flutter/.env`に保存してください。
キーは`FIREBASE_APPCHECK_DEBUG_TOKEN`です。
`flutter/.env.example`をコピーしてそこに書き込むようにしてください。

6. Firebaseエミュレーターを使えるようにしましょう

Firebaseのプロジェクトには私のクレカが登録されています。
私を助ける意味でもチームの予算を越さないためにも本当のFirebaseを使うのはできるだけ控え、ローカルのエミュレーターを使用しましょう。
```sh
cd firebase
firebase emulator:start
```
これでエミュレーターが起動するはずです。
ローカルのエミュレーターを使った開発をする場合はこれをずっと動かしたままにします。
[localhost:4000](localhost:4000)にアクセスすると実際の挙動を確認したり、一部修正したりすることができます。
ここでならいくらでもfunctionsを呼び出したりファイルをアップロードしても問題ありません。
flutterは次のように起動してください。
もしくは、`launch.json`に`debug with emulator`として用意しました。
```sh
flutter run -d chrome --dart-define=USE_FIREBASE_EMULATORS=true
```