#!/usr/bin/env bash
# ByeByeClaw - Uninstall all Claw-family AI agent tools / 一键卸载所有 Claw 家族 AI Agent 工具
# https://github.com/wanikua/byebyeclaw
#
# Supported / 支持:
#   OpenClaw, ZeroClaw, NanoClaw, IronClaw, NullClaw, TinyClaw,
#   NanoBot, MicroClaw, RayClaw, SharpClaw, MoltBot,
#   and derivatives / 及其衍生品

set -euo pipefail

# --- i18n / 国际化 ---

detect_lang() {
    local lang="${LANG:-${LC_ALL:-${LANGUAGE:-en}}}"
    if [[ "$lang" =~ ^zh ]]; then
        echo "zh"
    else
        echo "en"
    fi
}

LANG_CODE="${BYEBYECLAW_LANG:-$(detect_lang)}"

t() {
    local key="$1"
    if [ "$LANG_CODE" = "zh" ]; then
        case "$key" in
            title)          echo "👋 ByeByeClaw - Claw 家族一键卸载工具" ;;
            dry_run)        echo "[DRY RUN 模式 - 仅扫描不删除]" ;;
            keep_config)    echo "[保留配置文件]" ;;
            scanning)       echo "🔍 正在扫描 Claw 家族安装痕迹..." ;;
            npm_global)     echo "npm 全局包" ;;
            npm_pkg)        echo "npm 全局包" ;;
            npm_fuzzy)      echo "npm 全局包 (模糊匹配)" ;;
            pip_pkg)        echo "pip 包" ;;
            pipx_pkg)       echo "pipx 包" ;;
            pip_sec)        echo "pip/pipx 包" ;;
            cargo_sec)      echo "cargo 安装" ;;
            cargo_bin)      echo "cargo 二进制" ;;
            bin_sec)        echo "二进制文件" ;;
            bin_file)       echo "二进制文件" ;;
            config_sec)     echo "配置/数据目录" ;;
            config_dir)     echo "配置目录" ;;
            config_keep)    echo "配置目录 (保留)" ;;
            cache_sec)      echo "缓存目录" ;;
            cache_dir)      echo "缓存目录" ;;
            systemd_sec)    echo "systemd 服务" ;;
            systemd_svc)    echo "systemd 服务" ;;
            systemd_user)   echo "systemd 用户服务" ;;
            launchd_sec)    echo "launchd 服务" ;;
            launchd_svc)    echo "launchd" ;;
            docker_sec)     echo "Docker 容器/镜像" ;;
            docker_ctn)     echo "Docker 容器" ;;
            docker_img)     echo "Docker 镜像" ;;
            vscode_sec)     echo "VS Code 扩展" ;;
            vscode_ext)     echo "VS Code 扩展" ;;
            proc_sec)       echo "进程" ;;
            proc_run)       echo "运行中的 Claw 进程" ;;
            cron_sec)       echo "cron 任务" ;;
            cron_found)     echo "crontab 中存在 Claw 相关任务" ;;
            shell_sec)      echo "Shell 配置" ;;
            shell_file)     echo "Shell 配置残留" ;;
            tmpfile_sec)    echo "临时文件" ;;
            tmpfile_dir)    echo "临时文件" ;;
            logfile_sec)    echo "日志文件" ;;
            logfile_dir)    echo "日志文件" ;;
            clean)          echo "✅ 没有检测到任何 Claw 家族工具的安装痕迹。你的系统很干净！" ;;
            found_total)    echo "共检测到" ;;
            found_items)    echo "个项目需要清理。" ;;
            dry_done)       echo "📋 DRY RUN 完成，以上是扫描结果。去掉 --dry-run 参数执行真正的卸载。" ;;
            confirm)        echo "确认卸载以上所有项目？(y/N) " ;;
            cancelled)      echo "已取消卸载。" ;;
            cleaning)       echo "🧹 开始清理..." ;;
            uninstall)      echo "卸载" ;;
            delete)         echo "删除" ;;
            stop_disable)   echo "停止并禁用" ;;
            unload)         echo "卸载 launchd" ;;
            stop_rm_ctn)    echo "停止并删除容器" ;;
            rm_image)       echo "删除镜像" ;;
            kill_proc)      echo "终止 Claw 相关进程" ;;
            clean_cron)     echo "清理 crontab 中 Claw 任务" ;;
            clean_npm)      echo "清理 npm 缓存" ;;
            clean_shell)    echo "清理 Shell 配置残留" ;;
            try_sudo)       echo "尝试 sudo" ;;
            skip)           echo "跳过" ;;
            fail)           echo "失败" ;;
            done_ok)        echo "✅ 卸载完成！所有 Claw 家族工具已从你的系统中彻底移除。无残留。" ;;
            done_err1)      echo "⚠️  卸载完成，但有" ;;
            done_err2)      echo "个项目未能成功清理。请手动检查上述失败项。" ;;
            bye)            echo "👋 Bye bye, Claws! 🦞🦀" ;;
            usage1)         echo "用法" ;;
            usage2)         echo "仅扫描，不删除" ;;
            usage3)         echo "保留配置文件" ;;
            usage4)         echo "强制英文输出" ;;
            usage5)         echo "强制中文输出" ;;
        esac
    else
        case "$key" in
            title)          echo "👋 ByeByeClaw - Claw Family Uninstaller" ;;
            dry_run)        echo "[DRY RUN - scan only, no deletions]" ;;
            keep_config)    echo "[keeping config files]" ;;
            scanning)       echo "🔍 Scanning for Claw-family installations..." ;;
            npm_global)     echo "npm global packages" ;;
            npm_pkg)        echo "npm global" ;;
            npm_fuzzy)      echo "npm global (fuzzy match)" ;;
            pip_pkg)        echo "pip package" ;;
            pipx_pkg)       echo "pipx package" ;;
            pip_sec)        echo "pip/pipx packages" ;;
            cargo_sec)      echo "cargo installs" ;;
            cargo_bin)      echo "cargo binary" ;;
            bin_sec)        echo "binaries" ;;
            bin_file)       echo "binary" ;;
            config_sec)     echo "config/data dirs" ;;
            config_dir)     echo "config dir" ;;
            config_keep)    echo "config dir (keeping)" ;;
            cache_sec)      echo "cache dirs" ;;
            cache_dir)      echo "cache dir" ;;
            systemd_sec)    echo "systemd services" ;;
            systemd_svc)    echo "systemd service" ;;
            systemd_user)   echo "systemd user service" ;;
            launchd_sec)    echo "launchd services" ;;
            launchd_svc)    echo "launchd" ;;
            docker_sec)     echo "Docker containers/images" ;;
            docker_ctn)     echo "Docker container" ;;
            docker_img)     echo "Docker image" ;;
            vscode_sec)     echo "VS Code extensions" ;;
            vscode_ext)     echo "VS Code extension" ;;
            proc_sec)       echo "processes" ;;
            proc_run)       echo "running Claw processes" ;;
            cron_sec)       echo "cron jobs" ;;
            cron_found)     echo "Claw-related entries found in crontab" ;;
            shell_sec)      echo "shell configs" ;;
            shell_file)     echo "shell config residue" ;;
            tmpfile_sec)    echo "temp files" ;;
            tmpfile_dir)    echo "temp file" ;;
            logfile_sec)    echo "log files" ;;
            logfile_dir)    echo "log file" ;;
            clean)          echo "✅ No Claw-family tools detected. Your system is clean!" ;;
            found_total)    echo "Found" ;;
            found_items)    echo "items to clean up." ;;
            dry_done)       echo "📋 DRY RUN complete. Remove --dry-run to actually uninstall." ;;
            confirm)        echo "Confirm uninstall all items above? (y/N) " ;;
            cancelled)      echo "Cancelled." ;;
            cleaning)       echo "🧹 Cleaning up..." ;;
            uninstall)      echo "uninstall" ;;
            delete)         echo "remove" ;;
            stop_disable)   echo "stop & disable" ;;
            unload)         echo "unload launchd" ;;
            stop_rm_ctn)    echo "stop & remove container" ;;
            rm_image)       echo "remove image" ;;
            kill_proc)      echo "kill Claw processes" ;;
            clean_cron)     echo "clean Claw entries from crontab" ;;
            clean_npm)      echo "clean npm cache" ;;
            clean_shell)    echo "clean shell config residue" ;;
            try_sudo)       echo "trying sudo" ;;
            skip)           echo "skipped" ;;
            fail)           echo "failed" ;;
            done_ok)        echo "✅ Uninstall complete! All Claw-family tools have been removed. Zero residue." ;;
            done_err1)      echo "⚠️  Uninstall complete, but" ;;
            done_err2)      echo "items could not be cleaned. Please check manually." ;;
            bye)            echo "👋 Bye bye, Claws! 🦞🦀" ;;
            usage1)         echo "Usage" ;;
            usage2)         echo "scan only, no deletions" ;;
            usage3)         echo "keep config files" ;;
            usage4)         echo "force English output" ;;
            usage5)         echo "force Chinese output" ;;
        esac
    fi
}

# --- Colors ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
DIM='\033[2m'
BOLD='\033[1m'
NC='\033[0m'

# --- Args ---
DRY_RUN=false
KEEP_CONFIG=false
for arg in "$@"; do
    case "$arg" in
        --dry-run)      DRY_RUN=true ;;
        --keep-config)  KEEP_CONFIG=true ;;
        --lang=en)      LANG_CODE="en" ;;
        --lang=zh)      LANG_CODE="zh" ;;
        --help|-h)
            echo "$(t usage1): $0 [--dry-run] [--keep-config] [--lang=en|zh]"
            echo "  --dry-run      $(t usage2)"
            echo "  --keep-config  $(t usage3)"
            echo "  --lang=en      $(t usage4)"
            echo "  --lang=zh      $(t usage5)"
            exit 0
            ;;
    esac
done

echo ""
echo -e "${CYAN}$(t title)${NC}"
echo "============================================"
$DRY_RUN && echo -e "${YELLOW}   $(t dry_run)${NC}"
$KEEP_CONFIG && echo -e "${YELLOW}   $(t keep_config)${NC}"
echo ""

FOUND_ITEMS=()
FOUND_COUNT=0

found() {
    local type="$1" value="$2" desc="$3"
    echo -e "  ${RED}✗${NC} $desc"
    FOUND_ITEMS+=("$type:$value")
    FOUND_COUNT=$((FOUND_COUNT + 1))
}

# =====================================================================
# MASTER TARGET LIST — all known Claw-family names
# =====================================================================

NPM_PACKAGES=(
    "openclaw" "@openclaw/cli" "@openclaw/sdk"
    "zeroclaw" "@zeroclaw/cli"
    "nanoclaw" "ironclaw" "nullclaw" "tinyclaw"
    "nanobot" "microclaw" "rayclaw" "sharpclaw"
    "moltbot" "moltworker"
    "kelvinclaw" "openfang"
)

PIP_PACKAGES=("openclaw" "zeroclaw" "nanoclaw" "ironclaw" "nullclaw" "tinyclaw" "microclaw" "moltbot" "sharpclaw" "nanobot")

CARGO_PACKAGES=("zeroclaw" "ironclaw" "microclaw" "rayclaw" "nullclaw" "nanoclaw")

BINARY_NAMES=("openclaw" "zeroclaw" "nanoclaw" "ironclaw" "nullclaw" "tinyclaw" "nanobot" "microclaw" "rayclaw" "sharpclaw" "moltbot" "kelvinclaw" "openfang")

CONFIG_NAMES=("openclaw" "zeroclaw" "nanoclaw" "ironclaw" "nullclaw" "tinyclaw" "nanobot" "microclaw" "rayclaw" "sharpclaw" "moltbot" "kelvinclaw" "openfang")

# Broad regex for process/cron/fuzzy matching
CLAW_REGEX="openclaw|zeroclaw|nanoclaw|ironclaw|nullclaw|tinyclaw|microclaw|rayclaw|sharpclaw|moltbot|nanobot|kelvinclaw|openfang"

# ====================================
# SCAN / 扫描
# ====================================

echo -e "${YELLOW}$(t scanning)${NC}"
echo ""

# --- 1. npm global ---
echo -e "${DIM}  [$(t npm_global)]${NC}"
for pkg in "${NPM_PACKAGES[@]}"; do
    if npm list -g "$pkg" --depth=0 &>/dev/null; then
        found "npm" "$pkg" "$(t npm_pkg): $pkg"
    fi
done
# fuzzy
if command -v npm &>/dev/null; then
    while IFS= read -r pkg; do
        if [ -n "$pkg" ] && ! printf '%s\n' "${NPM_PACKAGES[@]}" | grep -qxF "$pkg"; then
            found "npm" "$pkg" "$(t npm_fuzzy): $pkg"
        fi
    done < <(npm list -g --depth=0 --parseable 2>/dev/null | xargs -I{} basename {} | grep -iE "claw|moltbot" || true)
fi

# --- 2. pip/pipx ---
echo -e "${DIM}  [$(t pip_sec)]${NC}"
for pkg in "${PIP_PACKAGES[@]}"; do
    if pip3 show "$pkg" &>/dev/null 2>&1; then
        found "pip" "$pkg" "$(t pip_pkg): $pkg"
    fi
    if command -v pipx &>/dev/null && pipx list 2>/dev/null | grep -qi "$pkg"; then
        found "pipx" "$pkg" "$(t pipx_pkg): $pkg"
    fi
done

# --- 3. cargo ---
echo -e "${DIM}  [$(t cargo_sec)]${NC}"
if [ -d "$HOME/.cargo/bin" ]; then
    for pkg in "${CARGO_PACKAGES[@]}"; do
        if [ -f "$HOME/.cargo/bin/$pkg" ]; then
            found "cargo" "$pkg" "$(t cargo_bin): ~/.cargo/bin/$pkg"
        fi
    done
fi

# --- 4. binaries ---
echo -e "${DIM}  [$(t bin_sec)]${NC}"
BINARY_DIRS=("/usr/local/bin" "/usr/bin" "$HOME/.local/bin" "$HOME/.npm-global/bin" "$HOME/bin" "/opt/homebrew/bin")
for dir in "${BINARY_DIRS[@]}"; do
    for name in "${BINARY_NAMES[@]}"; do
        bp="$dir/$name"
        if [ -f "$bp" ] || [ -L "$bp" ]; then
            found "bin" "$bp" "$(t bin_file): $bp"
        fi
    done
done

# --- 5. config/data dirs ---
echo -e "${DIM}  [$(t config_sec)]${NC}"
CONFIG_BASES=("$HOME/." "$HOME/.config/""$HOME/.local/share/")
[ "$(uname)" = "Darwin" ] && CONFIG_BASES+=("$HOME/Library/Application Support/" "$HOME/Library/Preferences/")
for base in "${CONFIG_BASES[@]}"; do
    for name in "${CONFIG_NAMES[@]}"; do
        dir="${base}${name}"
        if [ -d "$dir" ]; then
            if $KEEP_CONFIG; then
                echo -e "  ${YELLOW}⊘${NC} $(t config_keep): $dir"
            else
                size=$(du -sh "$dir" 2>/dev/null | cut -f1)
                found "dir" "$dir" "$(t config_dir): $dir ($size)"
            fi
        fi
    done
done

# --- 6. cache dirs ---
echo -e "${DIM}  [$(t cache_sec)]${NC}"
CACHE_BASES=("$HOME/.cache/")
[ "$(uname)" = "Darwin" ] && CACHE_BASES+=("$HOME/Library/Caches/")
for base in "${CACHE_BASES[@]}"; do
    for name in "${CONFIG_NAMES[@]}"; do
        dir="${base}${name}"
        if [ -d "$dir" ]; then
            size=$(du -sh "$dir" 2>/dev/null | cut -f1)
            found "dir" "$dir" "$(t cache_dir): $dir ($size)"
        fi
    done
done

# --- 7. systemd ---
echo -e "${DIM}  [$(t systemd_sec)]${NC}"
if command -v systemctl &>/dev/null; then
    for name in "${CONFIG_NAMES[@]}"; do
        for suffix in ".service" ".timer"; do
            svc="${name}${suffix}"
            if systemctl is-enabled "$svc" &>/dev/null 2>&1 || systemctl is-active "$svc" &>/dev/null 2>&1; then
                found "systemd" "$svc" "$(t systemd_svc): $svc"
            fi
            if systemctl --user is-enabled "$svc" &>/dev/null 2>&1 || systemctl --user is-active "$svc" &>/dev/null 2>&1; then
                found "systemd-user" "$svc" "$(t systemd_user): $svc"
            fi
        done
    done
fi

# --- 8. launchd (macOS) ---
echo -e "${DIM}  [$(t launchd_sec)]${NC}"
if [ "$(uname)" = "Darwin" ]; then
    for ldir in "$HOME/Library/LaunchAgents" "/Library/LaunchDaemons" "/Library/LaunchAgents"; do
        if [ -d "$ldir" ]; then
            while IFS= read -r plist; do
                [ -n "$plist" ] && found "launchd" "$plist" "$(t launchd_svc): $(basename "$plist")"
            done < <(find "$ldir" -name "*claw*" -o -name "*moltbot*" -o -name "*nanobot*" 2>/dev/null || true)
        fi
    done
fi

# --- 9. Docker ---
echo -e "${DIM}  [$(t docker_sec)]${NC}"
if command -v docker &>/dev/null; then
    while IFS= read -r c; do
        [ -n "$c" ] && found "docker-container" "$c" "$(t docker_ctn): $c"
    done < <(docker ps -a --format '{{.Names}}' 2>/dev/null | grep -iE "claw|moltbot|nanobot" | grep -viE "byebyeclaw" || true)
    while IFS= read -r img; do
        [ -n "$img" ] && found "docker-image" "$img" "$(t docker_img): $img"
    done < <(docker images --format '{{.Repository}}:{{.Tag}}' 2>/dev/null | grep -iE "claw|moltbot|nanobot" | grep -viE "byebyeclaw" || true)
fi

# --- 10. VS Code extensions ---
echo -e "${DIM}  [$(t vscode_sec)]${NC}"
for ext_base in "$HOME/.vscode/extensions" "$HOME/.vscode-server/extensions" "$HOME/.cursor/extensions" "$HOME/.vscode-insiders/extensions"; do
    if [ -d "$ext_base" ]; then
        while IFS= read -r ext_dir; do
            [ -n "$ext_dir" ] && found "vscode" "$ext_dir" "$(t vscode_ext): $(basename "$ext_dir")"
        done < <(find "$ext_base" -maxdepth 1 -type d \( -iname "*openclaw*" -o -iname "*zeroclaw*" -o -iname "*nanoclaw*" -o -iname "*ironclaw*" -o -iname "*nullclaw*" -o -iname "*tinyclaw*" -o -iname "*microclaw*" -o -iname "*nanobot*" \) 2>/dev/null)
    fi
done

# --- 11. processes ---
echo -e "${DIM}  [$(t proc_sec)]${NC}"
CLAUDE_PIDS=$(pgrep -f "$CLAW_REGEX" 2>/dev/null || true)
if [ -n "$CLAUDE_PIDS" ]; then
    pc=$(echo "$CLAUDE_PIDS" | wc -l | tr -d ' ')
    found "proc" "claw" "$(t proc_run): ${pc}"
fi

# --- 12. cron ---
echo -e "${DIM}  [$(t cron_sec)]${NC}"
if crontab -l 2>/dev/null | grep -qiE "$CLAW_REGEX"; then
    found "cron" "claw" "$(t cron_found)"
fi

# --- 13. shell config residue (PATH, aliases, env vars) ---
echo -e "${DIM}  [$(t shell_sec)]${NC}"
SHELL_FILES=("$HOME/.bashrc" "$HOME/.bash_profile" "$HOME/.profile" "$HOME/.zshrc" "$HOME/.zprofile" "$HOME/.config/fish/config.fish")
for sf in "${SHELL_FILES[@]}"; do
    if [ -f "$sf" ] && grep -qiE "openclaw|zeroclaw|nanoclaw|ironclaw|nullclaw|tinyclaw|microclaw|rayclaw|sharpclaw|moltbot|nanobot|kelvinclaw|openfang" "$sf" 2>/dev/null; then
        found "shell" "$sf" "$(t shell_file): $sf"
    fi
done

# --- 14. temp files ---
echo -e "${DIM}  [$(t tmpfile_sec)]${NC}"
for tmpbase in "/tmp" "${TMPDIR:-}"; do
    [ -z "$tmpbase" ] && continue
    while IFS= read -r td; do
        [ -n "$td" ] && found "dir" "$td" "$(t tmpfile_dir): $td"
    done < <(find "$tmpbase" -maxdepth 1 \( -iname "*claw*" -o -iname "*nanobot*" \) -not -name "byebyeclaw*" 2>/dev/null || true)
done

# --- 15. log files ---
echo -e "${DIM}  [$(t logfile_sec)]${NC}"
LOG_BASES=("$HOME/.local/state/" "$HOME/Library/Logs/")
for lb in "${LOG_BASES[@]}"; do
    for name in "${CONFIG_NAMES[@]}"; do
        ld="${lb}${name}"
        if [ -d "$ld" ]; then
            size=$(du -sh "$ld" 2>/dev/null | cut -f1)
            found "dir" "$ld" "$(t logfile_dir): $ld ($size)"
        fi
    done
done

echo ""

# ====================================
# RESULT / 结果
# ====================================

if [ $FOUND_COUNT -eq 0 ]; then
    echo -e "${GREEN}$(t clean)${NC}"
    echo ""
    exit 0
fi

echo -e "${YELLOW}$(t found_total) ${BOLD}${FOUND_COUNT}${NC}${YELLOW} $(t found_items)${NC}"
echo ""

if $DRY_RUN; then
    echo -e "${CYAN}$(t dry_done)${NC}"
    echo ""
    exit 0
fi

# ====================================
# CONFIRM / 确认
# ====================================

read -p "$(t confirm)" -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}$(t cancelled)${NC}"
    exit 0
fi

echo ""
echo -e "${CYAN}$(t cleaning)${NC}"
echo ""

# ====================================
# UNINSTALL / 卸载
# ====================================

ERRORS=0

ok()   { echo -e "${GREEN}✓${NC}"; }
fail() { echo -e "${RED}✗ $(t fail)${NC}"; ERRORS=$((ERRORS + 1)); }

do_rm() {
    local desc="$1"; shift
    echo -n "  $desc ... "
    if "$@" &>/dev/null; then ok
    else
        echo -ne "${YELLOW}$(t try_sudo)${NC} ... "
        if sudo "$@" &>/dev/null; then ok; else fail; fi
    fi
}

for item in "${FOUND_ITEMS[@]}"; do
    type="${item%%:*}"
    value="${item#*:}"

    case "$type" in
        npm)
            echo -n "  $(t uninstall) npm: $value ... "
            npm uninstall -g "$value" &>/dev/null && ok || fail
            ;;
        pip)
            echo -n "  $(t uninstall) pip: $value ... "
            pip3 uninstall -y "$value" &>/dev/null && ok || fail
            ;;
        pipx)
            echo -n "  $(t uninstall) pipx: $value ... "
            pipx uninstall "$value" &>/dev/null && ok || fail
            ;;
        cargo)
            echo -n "  $(t uninstall) cargo: $value ... "
            cargo uninstall "$value" &>/dev/null && ok || fail
            ;;
        bin)
            do_rm "$(t delete) $value" rm -f "$value"
            ;;
        dir)
            do_rm "$(t delete) $value" rm -rf "$value"
            ;;
        systemd)
            echo -n "  $(t stop_disable) $value ... "
            sudo systemctl stop "$value" &>/dev/null; sudo systemctl disable "$value" &>/dev/null
            ok
            ;;
        systemd-user)
            echo -n "  $(t stop_disable) $value ... "
            systemctl --user stop "$value" &>/dev/null; systemctl --user disable "$value" &>/dev/null
            ok
            ;;
        launchd)
            echo -n "  $(t unload) $(basename "$value") ... "
            launchctl unload "$value" &>/dev/null; rm -f "$value" &>/dev/null
            ok
            ;;
        docker-container)
            echo -n "  $(t stop_rm_ctn) $value ... "
            docker stop "$value" &>/dev/null; docker rm "$value" &>/dev/null
            ok
            ;;
        docker-image)
            echo -n "  $(t rm_image) $value ... "
            docker rmi "$value" &>/dev/null && ok || fail
            ;;
        vscode)
            echo -n "  $(t delete) $(t vscode_ext) $(basename "$value") ... "
            rm -rf "$value" &>/dev/null && ok || fail
            ;;
        proc)
            echo -n "  $(t kill_proc) ... "
            pkill -f "$CLAW_REGEX" &>/dev/null && ok || echo -e "${YELLOW}$(t skip)${NC}"
            ;;
        cron)
            echo -n "  $(t clean_cron) ... "
            crontab -l 2>/dev/null | grep -viE "$CLAW_REGEX" | crontab - 2>/dev/null
            ok
            ;;
        shell)
            echo -n "  $(t clean_shell): $value ... "
            # Only warn — don't auto-edit shell configs
            echo -e "${YELLOW}⚠ manual${NC}"
            ;;
    esac
done

# --- Extra cleanup ---
echo -n "  $(t clean_npm) ... "
npm cache clean --force &>/dev/null && ok || echo -e "${YELLOW}$(t skip)${NC}"

hash -r 2>/dev/null

echo ""

# ====================================
# DONE / 完成
# ====================================

if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}$(t done_ok)${NC}"
else
    echo -e "${YELLOW}$(t done_err1) $ERRORS $(t done_err2)${NC}"
fi

echo ""
echo -e "${CYAN}$(t bye)${NC}"
echo ""
