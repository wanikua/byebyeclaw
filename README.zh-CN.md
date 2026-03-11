# 👋 ByeByeClaw

[English](./README.md)

**一行命令卸载所有 Claw 家族 AI Agent。无残留。**

装了一堆 Claw 试完就忘？OpenClaw、ZeroClaw、NanoClaw、IronClaw... 配置目录东一个西一个，npm 全局包堆成山，Docker 容器还在后台跑？

一行命令，全部带走 👋

## 🚀 快速使用

**macOS / Linux：**

```bash
curl -fsSL https://raw.githubusercontent.com/wanikua/byebyeclaw/main/uninstall.sh | bash
```

**Windows (PowerShell)：**

```powershell
irm https://raw.githubusercontent.com/wanikua/byebyeclaw/main/uninstall.ps1 | iex
```

试完不想留？**Bye bye.** 🦀

## 🦞 支持卸载的工具

| 工具 | 星数 | 说明 |
|------|------|------|
| [OpenClaw](https://github.com/openclaw/openclaw) | 300k⭐ | Claw 家族本尊，个人 AI 助手 |
| [NanoBot](https://github.com/HKUDS/nanobot) | 32k⭐ | 超轻量 OpenClaw |
| [ZeroClaw](https://github.com/zeroclaw-labs/zeroclaw) | 26k⭐ | 快速轻量，Rust 实现 |
| [NanoClaw](https://github.com/qwibitai/nanoclaw) | 21k⭐ | 容器化运行，安全优先 |
| [IronClaw](https://github.com/nearai/ironclaw) | 9k⭐ | Rust 实现，隐私安全导向 |
| [NullClaw](https://github.com/nullclaw/nullclaw) | 6k⭐ | Zig 实现，极致轻量 |
| [TinyClaw](https://github.com/TinyAGI/tinyclaw) | 3k⭐ | 多 Agent 协作团队 |
| [MicroClaw](https://github.com/microclaw/microclaw) | 500⭐ | Rust 实现，嵌入聊天 |
| [RayClaw](https://github.com/rayclaw/rayclaw) | — | Rust 实现，多家族灵感 |
| [SharpClaw](https://github.com/imxcstar/sharpclaw) | — | .NET 实现 |
| [MoltBot/MoltWorker](https://github.com/cloudflare/moltworker) | 10k⭐ | Cloudflare Workers 版 |

## 🔍 卸载范围（无残留）

15 个扫描维度，一个不漏：

| 类别 | 详情 |
|------|------|
| 包管理器 | npm、pip、pipx、cargo 全局安装 |
| 二进制文件 | 所有 `*claw*`、`nanobot` 二进制 |
| 配置和数据 | `~/.openclaw/`、`~/.zeroclaw/`、`~/.config/*/` 等全部目录 |
| 缓存 | 所有 Claw 缓存目录 |
| 系统服务 | systemd、launchd (macOS)、Windows 服务 |
| Docker | 容器和镜像 |
| VS Code | Claw 相关扩展（含 Cursor、VS Code Insiders） |
| 定时任务 | crontab 条目 |
| 进程 | 运行中的 Claw 进程 |
| Shell 配置 | `.bashrc`、`.zshrc`、`.profile` 中的 PATH/alias 残留 |
| 临时文件 | `/tmp/*claw*` |
| 日志 | 状态和日志目录 |
| 注册表 | Windows 注册表条目（仅 PowerShell） |

## ⚙️ 参数

```bash
./uninstall.sh --dry-run        # 仅扫描，不删除
./uninstall.sh --keep-config    # 保留配置文件
./uninstall.sh --lang=zh        # 强制中文
./uninstall.sh --lang=en        # 强制英文
```

```powershell
.\uninstall.ps1 -DryRun         # 仅扫描
.\uninstall.ps1 -KeepConfig     # 保留配置文件
.\uninstall.ps1 -Lang zh        # 强制中文
.\uninstall.ps1 -Lang en        # 强制英文
```

## 📌 注意事项

- 删除前列出所有检测到的项目，**确认后才执行**
- 自动检测系统语言（中文/英文）
- Shell 配置文件仅标记不自动修改（建议手动检查）
- 不会影响其他无关工具

## 🔑 关键词

`openclaw 卸载` · `zeroclaw 卸载` · `nanoclaw 删除` · `ironclaw 卸载` · `nullclaw 删除` · `tinyclaw 卸载` · `nanobot 删除` · `microclaw 卸载` · `claw ai agent 卸载工具` · `claw 一键清理` · `claw 家族卸载` · `openclaw uninstall` · `remove claw tools`

## 📜 License

MIT License - Copyright (c) 2025 [wanikua](https://github.com/wanikua)
