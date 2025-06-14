# L4D2 Docker サーバー

[English](./README_EN.md) | [简体中文](./README.md) | 日本語

Debian 12 (Bookworm) ベースの最小限のLeft 4 Dead 2サーバーDockerイメージ。

## 特徴
- Debian 12安定版ベース
- 必要最小限のコンポーネントのみ
- マルチインスタンス展開対応
- リソース使用量設定可能
- プラグインとマップの動的読み込み対応

## クイックスタート

### イメージの取得
```bash
docker pull ayasehana/l4d2:latest
```

### Docker Composeでの展開
docker-compose.yml の作成:
```yaml
version: "3.8"
services:
  l4d2server:
    image: ayasehana/l4d2
    container_name: "l4d2server"
    command: "-game left4dead2 -sv_lan 0 +port 27015 +sv_clockcorrection_msecs 25 -timeout 10 -tickrate 100 +map c2m1_highway"
    restart: unless-stopped
    network_mode: host
    deploy:
      resources:
        limits:
          cpus: '2'
          memory: 2G
    volumes:
      - ./maps:/maps:ro
      - ./plugins:/plugins:ro
```

サービスの開始:
```bash
docker compose up -d
```

## サーバー管理

### サーバー起動
```bash
docker compose up -d
```

### ログの確認
```bash
docker logs l4d2server
```

### コンテナへの接続
```bash
docker exec -it l4d2server bash
```

### サーバー停止
```bash
docker compose down
```

### サーバー再起動
```bash
docker compose restart
```

## ディレクトリ構造
```
.
├── maps/           # マップディレクトリ
├── plugins/        # プラグインディレクトリ
└── docker-compose.yml
```

## リソース制限

docker-compose.yml の deploy 設定によるリソース制限:
- CPU制限：インスタンスごとに2コア推奨
- メモリ制限：インスタンスごとに2GB推奨
- 実際のハードウェア構成に応じて調整可能

## 注意事項

1. サーバーポートが使用されていないことを確認
2. プラグインとマップファイルの適切な権限設定
3. SSDストレージの使用を推奨
4. 定期的なログチェックによるサービス状態の確認

## トラブルシューティング

1. サーバーが起動しない場合
   ```bash
   # ログの確認
   docker logs l4d2server
   ```

2. サーバーに接続できない場合
   ```bash
   # ポートの確認
   netstat -tunlp | grep 27015
   ```

3. リソース使用量の問題
   ```bash
   # リソース使用状況の確認
   docker stats l4d2server
   ```

## ゲームの更新

コンテナには更新スクリプトが組み込まれており、イメージを再構築せずにゲームを直接更新できます：

```bash
# コンテナに入る
docker exec -it l4d2server bash

# 更新スクリプトを実行
./update.sh
```

更新後、コンテナを再起動する必要があります：
```bash
docker restart l4d2server
```

## ライセンス

MIT License

## リンク
- [Docker Hub](https://hub.docker.com/r/ayasehana/l4d2)
- [GitHub Repository](https://github.com/cH1yoi/l4d2-docker)
