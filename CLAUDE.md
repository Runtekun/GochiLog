# GochiLog - CLAUDE.md

グルメレビューアプリ。店舗へのレビュー投稿・マップ表示・ユーザープロフィール機能を持つ。

## 作業ルール

- コードを実装する前に、必ず実装方針をユーザーに説明して確認を取ること
- 複数ファイルにまたがる変更は特に事前説明を徹底すること

## 技術スタック

- Ruby on Rails 7.2
- PostgreSQL
- Tailwind CSS（tailwindcss-rails）
- Hotwire（Turbo + Stimulus）
- Devise（認証）+ OmniAuth（Googleログイン）
- Active Storage（画像アップロード）+ AWS S3（本番ストレージ）
- Ransack（検索）
- Kaminari（ページネーション）
- Google Maps JavaScript API + Places API（地図・Autocomplete）

## モデル構成

- `User` - Deviseで管理。name, bio, avatar(ActiveStorage)を持つ
- `Shop` - 店舗。name, latitude, longitude, address
- `Review` - レビュー。body, rating(1-5), image(ActiveStorage)。belongs_to :user, :shop
- `Comment` - コメント。body。belongs_to :user, :review
- `Like` - いいね。belongs_to :user, :review
- `Genre` - ジャンル。name
- `Relationship` - フォロー。follower_id, followed_id

## ルーティング

```
devise_for :users, controllers: { registrations: "users/registrations", omniauth_callbacks: "users/omniauth_callbacks" }
resources :users, only: [:show, :index] do
  resource :follow, only: [:create, :destroy]
end
resources :reviews do
  resource :like, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
end
get "maps", to: "maps#index"
get "terms", to: "static_pages#terms"
get "privacy", to: "static_pages#privacy"
root "home#index"
```

## 重要なカスタマイズ

- `Users::RegistrationsController` - パスワードなしでプロフィール更新できるよう `update_resource` をオーバーライド
- Deviseのパラメータ許可: sign_up → `name`、account_update → `name, bio, avatar`

## 画面構成

- ヘッダー: アバタークリックでドロップダウン（プロフィール・ログアウト）
- プロフィール詳細: `users#show` → アバター・名前・自己紹介・投稿レビュー一覧
- プロフィール編集: `devise/registrations#edit` → 名前・自己紹介・アバター・メール

## 画面遷移（プロフィール周り）

```
ヘッダー「プロフィール」→ user_path(current_user)（show）
show「プロフィールを編集」→ edit_user_registration_path（edit）
edit「キャンセル」→ user_path(current_user)（show）
```

## フロントエンド方針

- Alpine.jsは未導入。ドロップダウン等はvanilla JSで実装
- scriptタグはヘッダーパーシャルの `</header>` 直後に配置
- 外クリック判定は `stopPropagation` ではなく `contains()` を使う（Turbo対応）

## リリース状況

### MVPリリース済み機能
- ユーザー認証（Devise）
- レビュー投稿・一覧・詳細
- マップ表示
- ユーザープロフィール（表示・編集）

### 本リリース実装済み機能
- ① いいね機能（likes テーブル、Turbo Stream）
- ② ジャンル機能（genres テーブル、genre_id カラム）
- ③ フォロー機能（relationships テーブル、Turbo Stream）
- ④ 検索機能（Ransack、オートコンプリート datalist）
- ⑤ 現在地表示機能（Geolocation API、青丸マーカー）
- ⑥ SNSログイン（Google、OmniAuth）
- ⑦ OGP設定（静的、og:title / og:description / og:image）
- ⑧ レスポンシブ対応（Tailwind sm/md/lgブレークポイント）
- ⑨ オートログイン（Deviseのremember_me）
- ⑩ 利用規約・プライバシーポリシーページ
- ⑪ ローディングアニメーション（Stimulusローディングボタン）
- ⑫ 地図改善（現在地ボタン位置修正・Geolocationオプション改善）
- ⑬ Places Autocomplete（店名検索・地図自動移動）
- ⑭ 店舗住所表示（Geocoding API逆ジオコーディング）
- ⑮ コメント機能（comments テーブル、Turbo Stream）
- ⑯ ページネーション（Kaminari、レビュー一覧12件/ページ）
- ⑰ AWS S3連携（本番環境の画像ストレージ）
- ⑱ RSpec（リクエストテスト + モデルテスト）
- ⑲ CI（GitHub Actions、RSpecと連携）
- ⑳ Rubocop（Lintチェック）

### 残りのロードマップ
- [ ] 独自ドメイン反映（DNS・SSL対応）

## ブランチ戦略

- `main` - 本番
- `feature/*` - 機能開発
- 現在のブランチ: `main`

## 禁止事項

### Git・デプロイ
- `.env` などの機密ファイルをコミット・変更しない
- `main` / `master` へ直接 push しない
- `git push` は明示的に指示があるまでしない
- `git push --force` / `--force-with-lease` は確認なしで実行しない
- `git reset --hard` など破壊的なgitコマンドは確認してから実行
- `--no-verify` でhookをスキップしない

### データベース
- マイグレーションファイルを勝手に作らない（必ず確認してから）
- `db/schema.rb` を直接編集しない（必ずマイグレーション経由）
- 既存カラム・テーブルの削除を伴うマイグレーションは必ず確認する
- 本番環境のDB操作（`db:drop` など）は絶対にしない

### アーキテクチャ・依存関係
- `Gemfile` に新しい gem を追加する場合は必ず提案して確認する
- Tailwind以外のCSSフレームワークを追加しない
- 新しい外部APIやSaaSを勝手に導入しない
- 既存ファイルを大きくリファクタリングする場合は必ず事前に説明する
- 既存のアーキテクチャ（service / model / controller）を勝手に変更しない
