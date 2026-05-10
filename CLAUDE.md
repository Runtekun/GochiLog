# GochiLog - CLAUDE.md

グルメレビューアプリ。Rails 7.2 + PostgreSQL + Hotwire + Devise + Google Maps API。

## 作業ルール

- コードを実装する前に、必ず実装方針をユーザーに説明して確認を取ること
- 複数ファイルにまたがる変更は特に事前説明を徹底すること

## コマンド

```bash
docker compose exec web rails <command>   # Railsコマンドの基本形
docker compose exec web bundle exec rspec # テスト実行
docker compose exec web rails db:migrate  # マイグレーション
docker compose exec web rails routes      # ルーティング確認
```

## ブランチ戦略

- `main` - 本番
- `feature/*` - 機能開発

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
