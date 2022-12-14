# 株式会社ゆめみ iOS エンジニアコードチェック課題

## 概要

本プロジェクトは株式会社ゆめみ様からの課題として提供されたプロジェクトです。大内がIssueを解決してアプリの完成を目指します。

## アプリ仕様

本アプリは GitHub のリポジトリーを検索するアプリです。

![動作イメージ](README_Images/app.gif)

### 環境

- IDE：基本最新の安定版（本概要更新時点では Xcode 14.0.1）
- Swift：基本最新の安定版（本概要更新時点では Swift 5.5）
- 開発ターゲット：基本最新の安定版（本概要更新時点では iOS 15.0）
- サードパーティーライブラリーの利用：
    - SwiftLint

### 動作

1. 何かしらのキーワードを入力
2. GitHub API（`search/repositories`）でリポジトリーを検索し、結果一覧を概要（リポジトリ名）で表示
3. 特定の結果を選択したら、該当リポジトリの詳細（リポジトリ名、オーナーアイコン、プロジェクト言語、Star 数、Watcher 数、Fork 数、Issue 数）を表示

## 起動方法

1. `podinstall`を実行しCocoapodsでライブラリをインストールする
2. iOSEngineerCodeCheck.xcworkspaceを開く
※ 今回Cocoapodsを利用した理由については[こちら](../../wiki/Cocoapodsの利用について)をご参照ください。

## アーキテクチャについて

今回、アプリ全体の構造としてはVIPERアーキテクチャを採用しました。
