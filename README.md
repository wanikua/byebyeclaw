# 👋 ByeByeClaw

[中文文档](./README.zh-CN.md)

One-click uninstaller for **all Claw-family** AI agent tools. Clean, thorough, zero residue.

## 🦞 Supported Tools

| Tool | Stars | Description |
|------|-------|-------------|
| [OpenClaw](https://github.com/openclaw/openclaw) | 300k⭐ | The original personal AI assistant |
| [NanoBot](https://github.com/HKUDS/nanobot) | 32k⭐ | Ultra-lightweight OpenClaw |
| [ZeroClaw](https://github.com/zeroclaw-labs/zeroclaw) | 26k⭐ | Fast & small, built in Rust |
| [NanoClaw](https://github.com/qwibitai/nanoclaw) | 21k⭐ | Container-based, security-first |
| [IronClaw](https://github.com/nearai/ironclaw) | 9k⭐ | Privacy-focused Rust implementation |
| [NullClaw](https://github.com/nullclaw/nullclaw) | 6k⭐ | Minimal, built in Zig |
| [TinyClaw](https://github.com/TinyAGI/tinyclaw) | 3k⭐ | Multi-agent collaboration |
| [MicroClaw](https://github.com/microclaw/microclaw) | 500⭐ | Chat-embedded Rust agent |
| [RayClaw](https://github.com/rayclaw/rayclaw) | — | Multi-family inspired |
| [SharpClaw](https://github.com/imxcstar/sharpclaw) | — | .NET implementation |
| [MoltBot/MoltWorker](https://github.com/cloudflare/moltworker) | 10k⭐ | Cloudflare Workers edition |

## 🚀 Quick Start

**macOS / Linux:**

```bash
curl -fsSL https://raw.githubusercontent.com/wanikua/byebyeclaw/main/uninstall.sh | bash
```

**Windows (PowerShell):**

```powershell
irm https://raw.githubusercontent.com/wanikua/byebyeclaw/main/uninstall.ps1 | iex
```

## 🔍 What Gets Cleaned

| Category | Details |
|----------|---------|
| Package managers | npm, pip, pipx, cargo global installs |
| Binaries | All `*claw*`, `nanobot` binaries |
| Config & data | `~/.openclaw/`, `~/.zeroclaw/`, etc. |
| Cache | All cache directories |
| Services | systemd, launchd (macOS), Windows services |
| Docker | Containers and images |
| VS Code | Claw-related extensions (inc. Cursor, Insiders) |
| Cron/Tasks | crontab entries |
| Processes | Running Claw processes |
| Shell config | Detects PATH/alias residue in `.bashrc`, `.zshrc`, etc. |
| Temp files | `/tmp/*claw*` |
| Logs | State and log directories |
| Registry | Windows registry entries (PowerShell only) |

## ⚙️ Options

```bash
./uninstall.sh --dry-run        # Scan only, no deletions
./uninstall.sh --keep-config    # Keep config files
./uninstall.sh --lang=en        # Force English
./uninstall.sh --lang=zh        # Force Chinese
```

```powershell
.\uninstall.ps1 -DryRun         # Scan only
.\uninstall.ps1 -KeepConfig     # Keep config files
.\uninstall.ps1 -Lang en        # Force English
.\uninstall.ps1 -Lang zh        # Force Chinese
```

## 📌 Notes

- Lists everything before deleting — **confirms before proceeding**
- Auto-detects system language (Chinese / English)
- Shell config files are flagged but not auto-edited (manual review recommended)
- Won't affect unrelated tools

## 📜 License

MIT License - Copyright (c) 2025 [wanikua](https://github.com/wanikua)
