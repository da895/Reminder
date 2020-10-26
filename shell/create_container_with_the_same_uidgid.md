

## Create container with the same UID/GID with the HOST



在Docker容器中创建与宿主机相同UID/GID的用户，并确保文件权限一致性，可按照以下步骤操作：

### 1. **获取宿主机的UID/GID**

在宿主机执行：

```bash
echo "HOST_UID=$(id -u)" > .env
echo "HOST_GID=$(id -g)" >> .env
```

这会生成包含当前用户UID/GID的`.env`文件。

### 2. **创建Dockerfile**

```dockerfile
FROM ubuntu:latest

# 安装必要工具
RUN dpkg --add-architecture i386

RUN apt-get update && apt-get install -y sudo --no-install-recommends\
		vim-gtk3 aria2 curl python-is-python3 vim git universal-ctags\
        multiarch-support:i386

# 创建用户组和用户（暂用占位UID/GID，启动时动态修改）
RUN groupadd -r mygroup --gid 9999 && \
    useradd -rmg mygroup --uid 9999 myuser && \
    echo "myuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# 复制启动脚本并设置权限
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
```

### 3. **创建入口脚本 `entrypoint.sh`**

```bash
#!/bin/bash
# 从环境变量读取UID/GID
USER_ID=${HOST_UID:-9999}
GROUP_ID=${HOST_GID:-9999}

# 修改组GID
sudo groupmod -g $GROUP_ID mygroup
# 修改用户UID/GID并修复文件权限
sudo usermod -u $USER_ID -g $GROUP_ID myuser
sudo chown -R $USER_ID:$GROUP_ID /home/myuser

# 以myuser身份执行后续命令
exec sudo -u myuser "$@"
```

### 4. **构建并运行容器**

```bash
# 构建镜像
docker build -t my-container .

# 启动容器（传递宿主机的UID/GID）
docker run -it --rm \
  --env-file .env \
  -v /宿主机/目录:/容器/目录 \
  my-container
```

### 关键点说明：

1. **动态UID/GID修改**
   容器启动时通过`entrypoint.sh`修改预创建用户的UID/GID，使其匹配宿主机用户。
2. **文件权限修复**
   `chown`命令确保用户家目录权限更新，避免权限错误。
3. **卷挂载权限**
   挂载目录（`-v`参数）时，容器内的`myuser`用户与宿主机用户拥有相同UID/GID，保证文件读写权限一致。
4. **sudo免密配置**
   允许`myuser`无需密码使用sudo（按需启用）。

### 验证方法：

在容器内执行：

```bash
id myuser  # 应显示与宿主机相同的UID/GID
touch /容器/目录/test.txt  # 在宿主机查看文件属主应与预期一致
```

此方案解决了跨主机-容器的文件权限问题，同时保持镜像的通用性（不硬编码UID/GID）。