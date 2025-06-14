# L4D2 Docker 服务器

[English](./README_EN.md) | 简体中文 | [日本語](./README_JP.md)

基于 Debian 12 (Bookworm) 构建的精简版求生之路2服务器 Docker 镜像。

## 特点

- 基于 Debian 12 稳定版构建
- 最小化安装，仅包含必要组件
- 支持多实例部署
- 资源使用可配置
- 支持插件和地图的动态加载

## 快速开始

### 拉取镜像

```bash
docker pull ayasehana/l4d2:latest
```

### Docker Compose 部署

创建 docker-compose.yml:

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

启动服务：

```bash
docker compose up -d
```

## 服务器管理

### 启动服务器

```bash
docker compose up -d
```

### 查看日志

```bash
docker logs l4d2server
```

### 进入容器

```bash
docker exec -it l4d2server bash
```

### 停止服务器

```bash
docker compose down
```

### 重启服务器

```bash
docker compose restart
```

## 目录结构

```
.
├── plugins/        # 插件文件以及地图文件,软链接到/l4d2/left4dead2/
└── docker-compose.yml
```

## 资源限制说明

服务器资源限制通过 docker-compose.yml 中的 deploy 配置实现：

- CPU限制：建议每个实例2核
- 内存限制：建议每个实例2GB
- 可根据实际硬件配置调整

## 注意事项

1. 确保服务器端口未被占用
2. 插件和地图文件需要正确权限
3. 建议使用SSD存储
4. 定期检查日志确保服务运行状态

## 故障排除

1. 服务器无法启动

   ```bash
   # 检查日志
   docker logs l4d2server
   ```
2. 无法连接服务器

   ```bash
   # 检查端口
   netstat -tunlp | grep 27015
   ```
3. 资源使用异常

   ```bash
   # 检查资源使用
   docker stats l4d2server
   ```

## 游戏更新

容器内置了更新脚本，可以直接在容器内更新游戏，无需重新构建镜像：

```bash
# 进入容器
docker exec -it l4d2server bash

# 运行更新脚本
./update.sh
```

更新完成后需要重启容器：

```bash
docker restart l4d2server
```

## 许可证

MIT License

## 相关链接

- [Docker Hub](https://hub.docker.com/r/ayasehana/l4d2)
- [GitHub Repository](https://github.com/cH1yoi/l4d2-docker)
