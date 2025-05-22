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

3. 実行しましょう
VSCodeなら`F5`キーを押せば起動します。
コマンドならこんな感じ
```sh
flutter run -d chrome
```

## Coding
Flutterでは自動コード生成をよく用います。
これを行なってくれるのがBuild Runnerです。
riverpodやfreezedを使うクラスをいじった後は場合は次のコマンドを実行しましょう。
```sh
flutter pub run build_runner build --delete-conflicting-outputs
```
毎回実行するのは面倒だし時間もかかるので、次のコマンドを常時実行していれば問題ないです。
```sh
flutter pub run build_runner watch --delete-conflicting-outputs
```
もしくは[Build Runner](https://marketplace.visualstudio.com/items?itemName=GaetSchwartz.build-runner)という拡張機能を使うこともできます。
`Ctrl-shift-B`で自動コード生成して自動コード生成してくれます。
もしくは、左下に`(目のアイコン) Watch`があると思うのでコードを書き始めたらそれをクリックしておけば、常時ファイルの変更を監視してコード生成してくれます。
コード生成がうまくいっているかはエディターの`出力>Build Runner`から確認できます。