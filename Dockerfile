# ベースイメージ
FROM python:3.10-slim

# 作業ディレクトリ
WORKDIR /app

# 依存関係をコピーしてインストール
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# アプリをコピー
COPY . .

# Cloud Run が使うポート環境変数
ENV PORT=8080

# Flask を起動
CMD ["python", "app.py"]
