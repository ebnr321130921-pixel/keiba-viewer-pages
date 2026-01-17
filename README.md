# Keiba Viewer - GitHub Pages 公開テンプレート

このリポジトリは **「既存の別リポジトリ」とは別リンク** で、スマホから閲覧できる **GitHub Pages** を作るための最小テンプレートです。

## できること
- `docs/keiba_viewer.html` を GitHub Pages で公開
- `docs/index.html` は `keiba_viewer.html` に自動リダイレクト
- `push` すると Actions が Pages にデプロイ

---

## 手順（GitHubのTop repositories画面から作成）

1. GitHubを開き、上部メニューやホームの **Top repositories** 付近からでもOKなので、右上の **「＋」**（Create new…）を押します  
2. **New repository** を選びます  
3. Repository name に例として `keiba-viewer-pages`（任意）を入力  
   - **Public 推奨**（スマホからログイン無しで見たい場合）
4. **Add a README file** は **不要**（このテンプレに含まれます）
5. **Create repository** を押します

---

## テンプレ配置（このzipを使う場合）

1. 作成したリポジトリを開く
2. **Add file → Upload files**
3. このテンプレの中身（`docs/`, `.github/`, `scripts/`, `README.md`）をドラッグ＆ドロップでアップロード
4. Commit します

---

## Pages 有効化（最初の1回だけ）

1. リポジトリの **Settings**
2. 左メニュー **Pages**
3. **Build and deployment** の Source は **GitHub Actions** を選択（このテンプレのworkflowが動きます）

---

## 公開URL（別リンクになります）
- `https://<あなたのユーザー名>.github.io/<リポジトリ名>/`

例）リポジトリ名が `keiba-viewer-pages` の場合  
`https://<あなたのユーザー名>.github.io/keiba-viewer-pages/`

---

## 更新方法（ローカルでHTML生成 → Pagesへ反映）

1. ローカルで `Viwer_EDIT.py` を実行して `keiba_viewer.html` を生成
2. リポジトリ直下で下記を実行（テンプレ同梱）
   ```bash
   ./scripts/publish_to_pages.sh
   git commit -m "update viewer"
   git push
   ```
3. 数十秒〜数分で Pages が更新されます

※もしファイル名が変わる場合は `docs/index.html` のリンク先も合わせてください。

