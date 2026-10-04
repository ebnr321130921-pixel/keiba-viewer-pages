# 起動・検証ツール一覧

2026-10-04整理。普段使う起動コマンドは以下の5本。用途が異なるため統合しない。
ファイル名を維持し、既存のショートカットや手動運用を変更しない。

|コマンド|実行するコード|用途|
|---|---|---|
|`Keiba_Sim_auto.command`|`Keiba_Sim.py`|通常の自動運転。収集・予測・買い目・Viewer等のパイプライン|
|`umanity_collect_daily_uindex_and_results.command`|同名の `.py`|単独の範囲再収集。起動後にターミナルで日付範囲を入力|
|`夜間_追加データ収集.command`|`collect_umanity_supplemental.py`|今日・翌日の既存Indexへの夜間補完。21時まで待ち、バックグラウンドで1回実行|
|`purchase_system/auto_purchase.command`|`keiba_purchase.app panel`|購入画面を開く。既にサーバーが動いていれば再利用|
|`purchase_system/run_stage.command`|`keiba_purchase.app stage`|実サイトの購入確認段階までの専用操作。通常の収集には使わない|

## 検証コードの置き場所

- `purchase_system/tests/`: 現行処理の自動回帰テスト。実データの再収集や購入とは別。
- `purchase_system/analysis/`: 手動の精度・回収率比較、校正器の再学習、UI検証。
  再学習・出力更新を行うツールもあるため、一覧を見る目的で一括実行しない。
- `build_course_bias_report.py`: 現行の脚質推定・競馬場相互作用を使う手動レポート。
- `purchase_system/analysis/validate_flat_race_tickets.py`: 平場の見送り・3連単・3連複BOX/1軸/2軸等を時系列・同一予算で比較。結果と当日の比較候補を出す。このツールは本番採用・購入・再収集をしない。最新Rの仕様と結果は`docs/flat_purchase_model.md`、初回比較の記録は`docs/flat_race_ticket_branch.md`。
- `purchase_system/analysis/validate_conditional_trio.py`: 2頭軸6点200円、1頭軸、軸なしBOXを突出度で切り替える候補の同一予算比較。1,000円の10点対5点も照合する。購入・本番設定変更はしない。詳細は`docs/conditional_trio_comparison.md`。
- `docs/`: 仕様と検証結果の説明。`outputs/`等の既存レポートは検証根拠として保持。

回帰テストの実行例:

```sh
PYTHONPATH=purchase_system/src .venv314/bin/python -m unittest discover -s purchase_system/tests -p 'test_*.py'
```

## 今回取り除いたもの

- `Validation.py`: 旧脚質・結果人気/確定オッズを用いた旧診断。実オッズ時系列を使う現行診断と区別が難しく、実行元からの参照もないため削除。
- `axis_string_model_validation.py`: 旧10点・固定期間の軸/紐実験。現行の校正・購入方式検証を維持し、旧単発実験は削除。
- `outputs/supplemental_sample_20261003/probe_tabs.py`: 初回ページ調査用。現在の通常収集には不要で、不要なHTML/JSON保存経路も持つため削除。
- `gitignore.txt`: `.gitignore`と重複する旧テンプレート。実際にGitが使用する `.gitignore`を維持。
- `collect_umanity_supplemental.py`の旧リンク列挙・汎用テーブル抽出・HTML/JSON保存関数。
  現行は共通の`umanity_index_features.py`を通してIndex/Merged CSVへ保存する。

削除した旧保存関数専用の3テストも削除した。アクセス拒否・馬番/馬名照合・
異なるレースのリンク拒否・既存値保持・取得時刻・ロックの保護は現行経路で維持する。
学習済みモデル、キャッシュ、Index/Results/Merged/Predict、購入履歴、過去のレポートは削除しない。
今回は削除ファイルのバックアップを作っていない。

## 整理後の確認

変更経路を含む76テストはPython 3.14と3.10で通過。
夜間ツールのdry-runで2026-10-03/04各24レースを確認した。
5本のコマンドはシェル構文確認済み。収集・購入・自動運転のジョブは起動していない。

全体222テストは215件通過、6エラー・1失敗。
2026-09-27等の固定レースを現在のViewerから探すテストと、
再計算可能な保存予測に固定馬番を期待するテストが残っている。
これらの再現性は別途修正が必要で、今回の整理で全体テストが通過したとは扱わない。
購入保護の検証を弱めないため、失敗するテストを隠す目的で削除しない。
