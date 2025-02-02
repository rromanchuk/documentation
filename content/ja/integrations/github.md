---
categories:
  - Source Control
  - Collaboration
  - issue tracking
ddtype: クローラー
dependencies: []
description: サービスのパフォーマンスに影響するコミットとプルリクエストを特定
doc_link: 'https://docs.datadoghq.com/integrations/github/'
git_integration_title: github
has_logo: true
integration_title: GitHub
is_public: true
kind: インテグレーション
manifest_version: '1.0'
name: github
public_title: Datadog-GitHub インテグレーション
short_description: サービスのパフォーマンスに影響するコミットとプルリクエストを特定
version: '1.0'
---
{{< img src="integrations/github/git_integration_screen.png" alt="Git event" responsive="true" popup="true">}}

## 概要

Datadog で GitHub コミットをキャプチャして、以下のことができます。

  * コード変更の新しい機能を追跡できます。
  * 新しいコード変更がシステムアラートやビルドの失敗につながったことを検知できます。
  * Datadog イベントストリームで、コードの変更についてチームで議論できます。

## セットアップ

### インストール

#### GitHub

1. GitHub プロジェクトの Settings ページに移動します。
2. 左側のナビゲーションメニューで Webhooks エントリを選択します。
3. Add Webhook ボタンをクリックします。

    {{< img src="integrations/github/github_first_steps.png" alt="github first steps" responsive="true" popup="true" style="width:80%;">}}

4. 以下の URL を Payload URL フィールドに追加します。`<DATADOG_API_KEY>` は、[ご使用の Datadog API キー][1]に置き換えてください。

    ```
    https://app.datadoghq.com/intake/webhook/github?api_key=<DATADOG_API_KEY>
    ```

5. Content Type を `application/json` に設定します。

    {{< img src="integrations/github/webhook_configuration_2.png" alt="Webhook configuration" responsive="true" popup="true" style="width:80%;">}}

6. Which events would you like to trigger this webhook? では、Let me select individual events. オプションを使用して、Datadog に何を送信するかを選択できます。Datadog-GitHub インテグレーションでは以下がサポートされています。
    * プッシュ (新しいコミット)
    * 作成と削除 (タグ用)
    * プルリクエスト
    * 問題
    * すべてのコメント

#### Datadog

1. [Datadog GitHub インテグレーション][2]をインストールします。
2. リポジトリごとに、監視するブランチを追加します。ユーザーまたはオーガニゼーションのすべてのリポジトリを追加する場合は、ワイルドカードを使用します。
    たとえば、DataDog/Documentation リポジトリの `master` ブランチに関連するすべてのイベントを収集する場合は、以下のように設定します。

    {{< img src="integrations/github/github_classic_configuration.png" alt="github classic configuration" responsive="true" popup="true" style="width:50%;">}}

    DataDog オーガニゼーションの**すべての** `master` ブランチに関連するすべてのイベントを収集する場合は、次のように設定します。

    {{< img src="integrations/github/get_all_branches.png" alt="github all branches" responsive="true" popup="true" style="width:50%;">}}

## 収集データ

インテグレーションが完了すると、選択したイベントが Datadog イベントストリームに表示されるようになります。ダッシュボードの左上の検索バーに `sources:github` と入力すると、GitHub のイベントがダッシュボードのグラフに重ねて表示されます。


## トラブルシューティング

ご不明な点は、[Datadog のサポートチーム][3]までお問合せください。

[1]: https://app.datadoghq.com/account/settings#api
[2]: https://app.datadoghq.com/account/settings#integrations/github
[3]: https://docs.datadoghq.com/ja/help


{{< get-dependencies >}}