<# 
.SYNOPSIS
    ByeByeClaw - Uninstall all Claw-family AI agent tools / 一键卸载所有 Claw 家族 AI Agent 工具
.DESCRIPTION
    Supports / 支持: OpenClaw, ZeroClaw, NanoClaw, IronClaw, NullClaw, TinyClaw,
    NanoBot, MicroClaw, RayClaw, SharpClaw, MoltBot,
    and derivatives / 及其衍生品
.LINK
    https://github.com/wanikua/byebyeclaw
#>

param(
    [switch]$DryRun,
    [switch]$KeepConfig,
    [ValidateSet("en","zh")]
    [string]$Lang
)

$ErrorActionPreference = "Continue"

# --- i18n ---

function Detect-Lang {
    $culture = (Get-Culture).Name
    if ($culture -match "^zh") { return "zh" }
    return "en"
}

if (-not $Lang) { $Lang = Detect-Lang }

function T($key) {
    $zh = @{
        title         = "👋 ByeByeClaw - Claw 家族一键卸载工具"
        dry_run       = "[DRY RUN 模式 - 仅扫描不删除]"
        keep_config   = "[保留配置文件]"
        scanning      = "🔍 正在扫描 Claw 家族安装痕迹..."
        npm_sec       = "npm 全局包"
        pip_sec       = "pip 包"
        cargo_sec     = "cargo 安装"
        bin_sec       = "二进制文件"
        config_sec    = "配置/数据目录"
        config_keep   = "保留"
        cache_sec     = "缓存目录"
        vscode_sec    = "VS Code 扩展"
        docker_sec    = "Docker 容器/镜像"
        service_sec   = "Windows 服务"
        proc_sec      = "进程"
        reg_sec       = "注册表"
        tmpfile_sec   = "临时文件"
        clean         = "✅ 没有检测到任何 Claw 家族工具的安装痕迹。你的系统很干净！"
        found_pre     = "共检测到"
        found_post    = "个项目需要清理。"
        dry_done      = "📋 DRY RUN 完成，以上是扫描结果。去掉 -DryRun 参数执行真正的卸载。"
        confirm       = "确认卸载以上所有项目？(y/N)"
        cancelled     = "已取消卸载。"
        cleaning      = "🧹 开始清理..."
        uninstall     = "卸载"
        delete        = "删除"
        stop_svc      = "停止服务"
        kill_proc     = "终止 Claw 相关进程"
        clean_npm     = "清理 npm 缓存"
        clean_reg     = "清理注册表"
        fail          = "失败"
        skip          = "跳过"
        done_ok       = "✅ 卸载完成！所有 Claw 家族工具已从你的系统中彻底移除。无残留。"
        done_err_pre  = "⚠️  卸载完成，但有"
        done_err_post = "个项目未能成功清理。请手动检查上述失败项。"
        bye           = "👋 Bye bye, Claws! 🦞🦀"
    }
    $en = @{
        title         = "👋 ByeByeClaw - Claw Family Uninstaller"
        dry_run       = "[DRY RUN - scan only, no deletions]"
        keep_config   = "[keeping config files]"
        scanning      = "🔍 Scanning for Claw-family installations..."
        npm_sec       = "npm global packages"
        pip_sec       = "pip packages"
        cargo_sec     = "cargo installs"
        bin_sec       = "binaries"
        config_sec    = "config/data dirs"
        config_keep   = "keeping"
        cache_sec     = "cache dirs"
        vscode_sec    = "VS Code extensions"
        docker_sec    = "Docker containers/images"
        service_sec   = "Windows services"
        proc_sec      = "processes"
        reg_sec       = "registry"
        tmpfile_sec   = "temp files"
        clean         = "✅ No Claw-family tools detected. Your system is clean!"
        found_pre     = "Found"
        found_post    = "items to clean up."
        dry_done      = "📋 DRY RUN complete. Remove -DryRun to actually uninstall."
        confirm       = "Confirm uninstall all items above? (y/N)"
        cancelled     = "Cancelled."
        cleaning      = "🧹 Cleaning up..."
        uninstall     = "uninstall"
        delete        = "remove"
        stop_svc      = "stop service"
        kill_proc     = "kill Claw processes"
        clean_npm     = "clean npm cache"
        clean_reg     = "clean registry"
        fail          = "failed"
        skip          = "skipped"
        done_ok       = "✅ Uninstall complete! All Claw-family tools removed. Zero residue."
        done_err_pre  = "⚠️  Uninstall complete, but"
        done_err_post = "items could not be cleaned. Please check manually."
        bye           = "👋 Bye bye, Claws! 🦞🦀"
    }
    if ($Lang -eq "zh") { return $zh[$key] } else { return $en[$key] }
}

Write-Host ""
Write-Host (T "title") -ForegroundColor Cyan
Write-Host "============================================"
if ($DryRun)    { Write-Host "   $(T 'dry_run')" -ForegroundColor Yellow }
if ($KeepConfig){ Write-Host "   $(T 'keep_config')" -ForegroundColor Yellow }
Write-Host ""

$foundItems = @()

function Found($Type, $Value, $Desc) {
    Write-Host "  ✗ $Desc" -ForegroundColor Red
    $script:foundItems += @{type=$Type; value=$Value}
}

# =====================================================================
# MASTER TARGET LIST
# =====================================================================

$npmPackages = @(
    "openclaw", "@openclaw/cli", "@openclaw/sdk",
    "zeroclaw", "@zeroclaw/cli",
    "nanoclaw", "ironclaw", "nullclaw", "tinyclaw",
    "nanobot", "microclaw", "rayclaw", "sharpclaw",
    "moltbot", "moltworker",
    "kelvinclaw", "openfang"
)

$pipPackages = @("openclaw","zeroclaw","nanoclaw","ironclaw","nullclaw","tinyclaw","microclaw","moltbot","sharpclaw","nanobot")

$cargoPackages = @("zeroclaw","ironclaw","microclaw","rayclaw","nullclaw","nanoclaw")

$binaryNames = @("openclaw","zeroclaw","nanoclaw","ironclaw","nullclaw","tinyclaw","nanobot","microclaw","rayclaw","sharpclaw","moltbot","kelvinclaw","openfang")

$configNames = @("openclaw","zeroclaw","nanoclaw","ironclaw","nullclaw","tinyclaw","nanobot","microclaw","rayclaw","sharpclaw","moltbot","kelvinclaw","openfang")

$clawRegex = "openclaw|zeroclaw|nanoclaw|ironclaw|nullclaw|tinyclaw|microclaw|rayclaw|sharpclaw|moltbot|nanobot|kelvinclaw|openfang"

# ====================================
# SCAN
# ====================================

Write-Host (T "scanning") -ForegroundColor Yellow
Write-Host ""

# --- 1. npm global ---
Write-Host "  [$(T 'npm_sec')]" -ForegroundColor DarkGray
foreach ($pkg in $npmPackages) {
    $r = npm list -g $pkg --depth=0 2>$null
    if ($LASTEXITCODE -eq 0) { Found "npm" $pkg "$(T 'npm_sec'): $pkg" }
}
# fuzzy
$allGlobal = npm list -g --depth=0 --parseable 2>$null
if ($allGlobal) {
    $allGlobal | ForEach-Object { Split-Path $_ -Leaf } | Where-Object { $_ -match $clawRegex } | ForEach-Object {
        if ($_ -notin $npmPackages) { Found "npm" $_ "$(T 'npm_sec') (fuzzy): $_" }
    }
}

# --- 2. pip ---
Write-Host "  [$(T 'pip_sec')]" -ForegroundColor DarkGray
foreach ($pkg in $pipPackages) {
    $r = pip show $pkg 2>$null
    if ($LASTEXITCODE -eq 0) { Found "pip" $pkg "$(T 'pip_sec'): $pkg" }
}

# --- 3. cargo ---
Write-Host "  [$(T 'cargo_sec')]" -ForegroundColor DarkGray
$cargoBin = "$env:USERPROFILE\.cargo\bin"
foreach ($pkg in $cargoPackages) {
    if (Test-Path "$cargoBin\$pkg.exe") { Found "cargo" $pkg "$(T 'cargo_sec'): $cargoBin\$pkg.exe" }
}

# --- 4. binaries ---
Write-Host "  [$(T 'bin_sec')]" -ForegroundColor DarkGray
$npmPrefix = npm config get prefix 2>$null
if ($npmPrefix) {
    foreach ($name in $binaryNames) {
        foreach ($ext in @(".cmd",".ps1",".exe","")) {
            $bp = "$npmPrefix\$name$ext"
            if (Test-Path $bp) { Found "bin" $bp "$(T 'bin_sec'): $bp" }
        }
    }
}

# --- 5. config/data dirs ---
Write-Host "  [$(T 'config_sec')]" -ForegroundColor DarkGray
$configBases = @("$env:USERPROFILE\.","$env:APPDATA\","$env:LOCALAPPDATA\","$env:PROGRAMDATA\")
foreach ($base in $configBases) {
    foreach ($name in $configNames) {
        $dir = "$base$name"
        if (Test-Path $dir) {
            if ($KeepConfig) {
                Write-Host "  ⊘ $(T 'config_sec') ($(T 'config_keep')): $dir" -ForegroundColor Yellow
            } else {
                $size = (Get-ChildItem -Recurse $dir -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum
                $sizeStr = if ($size -gt 1MB) { "{0:N1} MB" -f ($size/1MB) } else { "{0:N0} KB" -f ($size/1KB) }
                Found "dir" $dir "$(T 'config_sec'): $dir ($sizeStr)"
            }
        }
    }
}

# --- 6. VS Code extensions ---
Write-Host "  [$(T 'vscode_sec')]" -ForegroundColor DarkGray
foreach ($extBase in @("$env:USERPROFILE\.vscode\extensions","$env:USERPROFILE\.vscode-insiders\extensions","$env:USERPROFILE\.cursor\extensions")) {
    if (Test-Path $extBase) {
        Get-ChildItem -Directory $extBase -ErrorAction SilentlyContinue | Where-Object { $_.Name -match "openclaw|zeroclaw|nanoclaw|ironclaw|nullclaw|tinyclaw|microclaw|nanobot" } | ForEach-Object {
            Found "vscode" $_.FullName "$(T 'vscode_sec'): $($_.Name)"
        }
    }
}

# --- 7. Docker ---
Write-Host "  [$(T 'docker_sec')]" -ForegroundColor DarkGray
if (Get-Command docker -ErrorAction SilentlyContinue) {
    docker ps -a --format '{{.Names}}' 2>$null | Where-Object { $_ -match $clawRegex } | ForEach-Object { Found "docker-container" $_ "Docker container: $_" }
    docker images --format '{{.Repository}}:{{.Tag}}' 2>$null | Where-Object { $_ -match $clawRegex } | ForEach-Object { Found "docker-image" $_ "Docker image: $_" }
}

# --- 8. Windows services ---
Write-Host "  [$(T 'service_sec')]" -ForegroundColor DarkGray
Get-Service -ErrorAction SilentlyContinue | Where-Object { $_.Name -match $clawRegex } | ForEach-Object {
    Found "service" $_.Name "$(T 'service_sec'): $($_.Name)"
}

# --- 9. processes ---
Write-Host "  [$(T 'proc_sec')]" -ForegroundColor DarkGray
$procs = Get-Process -ErrorAction SilentlyContinue | Where-Object { $_.ProcessName -match $clawRegex }
if ($procs) { Found "proc" "claw" "$(T 'proc_sec'): $($procs.Count)" }

# --- 10. registry ---
Write-Host "  [$(T 'reg_sec')]" -ForegroundColor DarkGray
$regPaths = @("HKCU:\Software","HKLM:\Software")
foreach ($rp in $regPaths) {
    foreach ($name in $configNames) {
        if (Test-Path "$rp\$name") { Found "reg" "$rp\$name" "$(T 'reg_sec'): $rp\$name" }
    }
}

# --- 11. temp files ---
Write-Host "  [$(T 'tmpfile_sec')]" -ForegroundColor DarkGray
Get-ChildItem $env:TEMP -ErrorAction SilentlyContinue | Where-Object { $_.Name -match "openclaw|zeroclaw|nanoclaw|ironclaw|nullclaw|tinyclaw|microclaw|moltbot|nanobot" -and $_.Name -notmatch "byebyeclaw" } | ForEach-Object {
    Found "dir" $_.FullName "$(T 'tmpfile_sec'): $($_.FullName)"
}

Write-Host ""

# ====================================
# RESULT
# ====================================

if ($foundItems.Count -eq 0) {
    Write-Host (T "clean") -ForegroundColor Green
    Write-Host ""
    exit 0
}

Write-Host "$(T 'found_pre') $($foundItems.Count) $(T 'found_post')" -ForegroundColor Yellow
Write-Host ""

if ($DryRun) {
    Write-Host (T "dry_done") -ForegroundColor Cyan
    Write-Host ""
    exit 0
}

# ====================================
# CONFIRM
# ====================================

$confirm = Read-Host (T "confirm")
if ($confirm -ne "y" -and $confirm -ne "Y") {
    Write-Host (T "cancelled") -ForegroundColor Yellow
    exit 0
}

Write-Host ""
Write-Host (T "cleaning") -ForegroundColor Cyan
Write-Host ""

# ====================================
# UNINSTALL
# ====================================

$errors = 0

function Ok  { Write-Host "✓" -ForegroundColor Green }
function Fail { Write-Host "✗ $(T 'fail')" -ForegroundColor Red; $script:errors++ }

foreach ($item in $foundItems) {
    switch ($item.type) {
        "npm" {
            Write-Host -NoNewline "  $(T 'uninstall') npm: $($item.value) ... "
            npm uninstall -g $item.value 2>$null; if ($LASTEXITCODE -eq 0) { Ok } else { Fail }
        }
        "pip" {
            Write-Host -NoNewline "  $(T 'uninstall') pip: $($item.value) ... "
            pip uninstall -y $item.value 2>$null; if ($LASTEXITCODE -eq 0) { Ok } else { Fail }
        }
        "cargo" {
            Write-Host -NoNewline "  $(T 'uninstall') cargo: $($item.value) ... "
            cargo uninstall $item.value 2>$null; if ($LASTEXITCODE -eq 0) { Ok } else { Fail }
        }
        "bin" {
            Write-Host -NoNewline "  $(T 'delete') $($item.value) ... "
            try { Remove-Item -Force $item.value -ErrorAction Stop; Ok } catch { Fail }
        }
        "dir" {
            Write-Host -NoNewline "  $(T 'delete') $($item.value) ... "
            try { Remove-Item -Recurse -Force $item.value -ErrorAction Stop; Ok } catch { Fail }
        }
        "vscode" {
            Write-Host -NoNewline "  $(T 'delete') $(T 'vscode_sec') $(Split-Path $item.value -Leaf) ... "
            try { Remove-Item -Recurse -Force $item.value -ErrorAction Stop; Ok } catch { Fail }
        }
        "docker-container" {
            Write-Host -NoNewline "  $(T 'delete') container $($item.value) ... "
            docker stop $item.value 2>$null; docker rm $item.value 2>$null; Ok
        }
        "docker-image" {
            Write-Host -NoNewline "  $(T 'delete') image $($item.value) ... "
            docker rmi $item.value 2>$null; if ($LASTEXITCODE -eq 0) { Ok } else { Fail }
        }
        "service" {
            Write-Host -NoNewline "  $(T 'stop_svc') $($item.value) ... "
            Stop-Service -Name $item.value -Force -ErrorAction SilentlyContinue; Ok
        }
        "proc" {
            Write-Host -NoNewline "  $(T 'kill_proc') ... "
            Get-Process | Where-Object { $_.ProcessName -match $clawRegex } | Stop-Process -Force -ErrorAction SilentlyContinue; Ok
        }
        "reg" {
            Write-Host -NoNewline "  $(T 'clean_reg') $($item.value) ... "
            try { Remove-Item -Recurse -Force $item.value -ErrorAction Stop; Ok } catch { Fail }
        }
    }
}

Write-Host -NoNewline "  $(T 'clean_npm') ... "
npm cache clean --force 2>$null; Ok

Write-Host ""

# ====================================
# DONE
# ====================================

if ($errors -eq 0) {
    Write-Host (T "done_ok") -ForegroundColor Green
} else {
    Write-Host "$(T 'done_err_pre') $errors $(T 'done_err_post')" -ForegroundColor Yellow
}

Write-Host ""
Write-Host (T "bye") -ForegroundColor Cyan
Write-Host ""
