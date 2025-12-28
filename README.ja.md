# Flutterプロジェクト構造
本ドキュメントでは、クリーンでモジュラーなアーキテクチャに従ったFlutterプロジェクトの構成について説明します。

---

## フォルダ構造
```plaintext
lib/
├── main.dart                   # アプリケーションのエントリーポイント。runApp(AppBootstrap())を呼び出す
│
├── bootstrap/                  # 初期化とグローバル設定
│   ├── app_bootstrap.dart      # アプリの一般的な初期化(GetIt、HydratedBloc、グローバルサービス)
│   ├── app_config.dart         # エンドポイント、クライアント、グローバル変数の設定
│   └── injection.dart          # 機能別の依存関係登録とグローバル依存関係
│
├── core/                       # アプリ全体で再利用可能なロジックとリソース
│   ├── network/
│   │   ├── api_client.dart     # ベースクライアントと複数APIの依存性注入
│   │   ├── interceptors/
│   ├── error/
│   │   └── failure.dart                # グローバルなエラーと失敗のハンドリング
│   │   └── error_translations.dart     # エラーをユーザーフレンドリーなメッセージにマッピング
│   ├── i18n/
│   │   ├── localization.dart
│   │   └── en.arb / es.arb     # 国際化と翻訳ファイル
│   ├── themes/
│   │   ├── app_colors.dart
│   │   ├── app_text_styles.dart
│   │   └── app_theme.dart      # 色、タイポグラフィ、グローバルアプリテーマの定義
│   ├── services/
│   │   ├── analytics_service.dart
│   │   ├── notification_service.dart
│   │   ├── push_service.dart
│   │   └── crashlytics_service.dart # グローバルサービス(アナリティクス、通知、クラッシュリティクスなど)
│   ├── repositories/
│   │   └── user_repository.dart # 共有データリポジトリ
│   └── utils/
│       ├── validators.dart
│       ├── date_utils.dart
│       └── logger.dart         # 一般的なヘルパー関数とユーティリティ
│
├── features/                   # ドメインごとに分離されたアプリ機能
│   ├── auth/
│   │   ├── presentation/bloc/
│   │   ├── presentation/pages/
│   │   ├── data/remote/
│   │   ├── data/models/
│   │   └── domain/
│   └── home/
│       ├── presentation/bloc/
│       ├── presentation/pages/
│       ├── data/remote/
│       ├── data/models/
│       └── domain/
│
├── shared/                     # 再利用可能なコンポーネント、拡張機能、定数
│   ├── widgets/
│   ├── extensions/
│   └── constants/
│
├── data/                       # ローカルおよびリモートデータストレージ
│   ├── local/
│   └── remote/
│
├── blocs/                      # グローバルまたは共有BLoCのオプションフォルダ
│
├── utils/                      # 追加のユーティリティ関数
│
└── assets/                     # アプリリソース:画像、フォント、アイコンなど
```

---

## 注意事項

- 各**機能**は独自の構造を持つ:`presentation`、`data`、`domain`
- `core`には、テーマ、サービス、ユーティリティ、エラーハンドリングなど、再利用可能なロジックがすべて含まれる
- `bootstrap`はアプリの初期化と依存性注入を一元化
- `shared`には、任意の機能で使用できるウィジェット、拡張機能、定数が含まれる
- `data/local`と`data/remote`は、ローカル永続化ロジックとAPI通信を分離

---