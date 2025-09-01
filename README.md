# Cloud Runへのデプロイコマンド

```bash
gcloud run deploy iap-demo \
  --source . \
  --region asia-northeast1 \
  --allow-unauthenticated
```

リソースの設定画面でIAPを有効化するだけ

## Identity-Aware Proxy (IAP) とは

Google Cloud の **認証・認可ゲートウェイ** のようなサービスです。
具体的には、

* インターネット経由や社内ネットワークからアクセスされる **Web アプリや API への入口で、Google アカウントや IdP（Identity Provider）による認証を必須にする**
* 認証後は、Google Cloud IAM のロールを使って **「誰がどのアプリにアクセスできるか」** を制御できる

要は、アプリケーション側でログイン機能を実装しなくても、**IAP が手前で認証・認可を肩代わり**してくれる仕組みです。

---

## 使える対象

IAP が利用できるのは「HTTP(S) 経由で公開される Google Cloud リソース」です。代表的な対象は：

* **App Engine**
* **Cloud Run**
* **Cloud Functions（第2世代含む）**
* **Compute Engine / GKE の HTTP(S) アプリケーション**（ただし HTTPS Load Balancer 経由が必要）

---

## 「Cloud Runなどのアプリケーションがないと効果を発揮しない？」への回答

✅ **いいえ。Cloud Run が必須ではありません。**

IAP はあくまで「アプリや API を保護するための入口」です。
なので「保護したい HTTP(S) アプリやサービス」が存在すれば、そのバックエンドが **Cloud Run でも Compute Engine でも GKE でも OK** です。

逆に言うと、

* **IAP の背後にアプリケーションが無ければ意味がない**
* つまり「守る対象」がなければ効果を発揮しません

---

## ユースケース例

* 社内ユーザーだけが利用できる業務 Web アプリを公開したい
* 個人アプリに Google アカウントで簡易ログイン機能を付けたい
* Cloud Run の REST API を社外パートナーに限定的に公開したい
* VM 上で動くダッシュボードをインターネット公開するが、認証は Google Workspace で統一したい

---

👉 まとめると、
IAP は「Google アカウントや IAM を使って **Web アプリや API を認証・認可で保護するサービス**」。
Cloud Run 以外のバックエンドでも利用可能ですが、守る対象がないと効果はありません。
