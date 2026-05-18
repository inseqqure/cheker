`powershell
<#
    Inseqqure System Checker - Deep Edition with Anti-Thief Protection (2026)
    Fully protected against leaks, unauthorized access, and copying.
#>
param (
    [string]$Mode = "User",
    [string]$AllowedHWID = "NONE"
)

# Сразу очищаем экран Windows от лишних надписей
Clear-Host

# 🔗 1. СЮДА ВСТАВЬ СВОЙ ВЕБХУК ДИСКОРДА:
$webhookUrl = "https://discord.com/api/webhooks/1506025655836348559/M9dAvViJu81zgn8Kd9spwqopueMVQQajSCl9Tej3QHMLZs_fFy_Ly4FvqLHUursWExD_"

# ⛔ 2. ЧЁРНЫЙ СПИСОК (БАН ПО HWID) ДЛЯ ВОРИШЕК:
$BlacklistHWID = @(
    "СЮДА_МОЖНО_ВСТАВИТЬ_HWID_КРЫСЫ_ДЛЯ_БАНА"
)

# Получаем уникальный серийный номер материнской платы (HWID компьютера)
$currentHWID = (Get-CimInstance Win32_BaseBoard).SerialNumber.Trim()

# --- ПРОВЕРКА ЧЁРНОГО СПИСКА (ЖЁСТКИЙ ПИНОК ЗА СЛИВ) ---
if ($BlacklistHWID -contains $currentHWID) {
    Write-Host "=========================================" -ForegroundColor Black -BackgroundColor Red
    Write-Host "     YOU ARE BANNED FROM THIS SYSTEM     " -ForegroundColor Black -BackgroundColor Red
    Write-Host "=========================================" -ForegroundColor Black -BackgroundColor Red
    Write-Host "Goodbye, thief." -ForegroundColor Red
    
    # Отправляем лог в Дискорд, что забаненный воришка снова попался
    if ($webhookUrl -and $webhookUrl -like "http*") {
        $msg = "🚨 Забаненный воришка попытался запустить чекер!`nПК: $env:COMPUTERNAME ($env:USERNAME)`nHWID: `$currentHWID`"
        $json = [PSCustomObject]@{ content = $msg } | ConvertTo-Json -EnumsAsStrings
        Invoke-RestMethod -Uri $webhookUrl -Method Post -Body $json -ContentType "application/json" -ErrorAction SilentlyContinue
    }
    
    # Наказываем: принудительно выключаем компьютер воришке через 5 секунд
    shutdown /s /t 5 /c "Попытка кражи чекера. Доигрался!"
    exit
}

# --- ПРОВЕРКА АВТОРИЗАЦИИ (ЗАЩИТА ОТ СЛИВА КОМАНДЫ) ---
if ($AllowedHWID -eq "NONE" -or $currentHWID -ne $AllowedHWID) {
    Write-Host "=========================================" -ForegroundColor Red
    Write-Host "      ERROR: UNAUTHORIZED EXECUTION      " -ForegroundColor Red
    Write-Host "=========================================" -ForegroundColor Red
    Write-Host "This script is locked and cannot be run on this PC." -ForegroundColor Yellow
    Write-Host "Your HWID: $currentHWID" -ForegroundColor Gray
    Write-Host "Provide this HWID to the administrator." -ForegroundColor Gray
    
    # Скрытно отправляем админу лог попытки взлома
    if ($webhookUrl -and $webhookUrl -like "http*") {
        $msg = "⚠️ Попытка несанкционированного запуска чекера!`nПК: $env:COMPUTERNAME ($env:USERNAME)`nЧужой HWID: `$currentHWID`"
        $json = [PSCustomObject]@{ content = $msg } | ConvertTo-Json -EnumsAsStrings
        Invoke-RestMethod -Uri $webhookUrl -Method Post -Body $json -ContentType "application/json" -ErrorAction SilentlyContinue
    }
    
    Write-Host "`nPress ENTER to exit..."
    Read-Host
    exit
}

# --- БЛОК СКАНИРОВАНИЯ НА ЧИТЫ ---
# Названия читов перевёрнуты задом наперёд, чтобы их нельзя было прочитать в коде
$w = @('taehc','tcejni','koohreven','epav','tsrow','natlosron','atled','natlusrun','evisnepxe','cld','ecnuobdiuqil','neirka','laitsalec')
$kw = $w | % { $a = $_.ToCharArray(); [Array]::Reverse($a); -join $a }
$d = @()

# Проверяем запущенные процессы и логи Prefetch
Get-Process | Where-Object { $_.Name -match ($kw -join '|') } | % { $d += 'Proc:' + $_.Name }
Get-ChildItem "C:\Windows\Prefetch" -ErrorAction SilentlyContinue | Where-Object { $_.Name -match ($kw -join '|') } | % { $d += 'File:' + $_.Name }

$u = $d | Unique
$totalFound = if ($u) { $u.Count } else { 0 }

# Снова чистим экран перед выводом красивого меню
Clear-Host
[18.05.2026 22:39] : # --- ИНТЕРФЕЙС ДЛЯ АДМИНИСТРАТОРА (СИНИЙ С ЧЁРНЫМ) ---
if ($Mode -eq "Admin") {
    Write-Host "=====================================" -ForegroundColor Cyan -BackgroundColor Black
    Write-Host "         C H E C K E R   D E E P     " -ForegroundColor Cyan -BackgroundColor Black
    Write-Host "=====================================" -ForegroundColor DarkGray -BackgroundColor Black
    Write-Host "TOTAL DETECTIONS FOUND: $totalFound" -ForegroundColor Yellow -BackgroundColor Black
} 
# --- ИНТЕРФЕЙС ДЛЯ ОБЫЧНОГО ИГРОКА (КРАСНЫЙ С СЕРЫМ) ---
else {
    Write-Host '=== INSEQQURE SYSTEM CHECKER ===' -ForegroundColor Red
    Write-Host "TOTAL DETECTIONS FOUND: $totalFound" -ForegroundColor Yellow
    Write-Host "-------------------------------------" -ForegroundColor DarkGray
}

# Вывод найденных читов на экран компьютера
if ($u) {
    foreach ($item in $u) { 
        if ($Mode -eq "Admin") { Write-Host "[!] $item" -ForegroundColor Blue -BackgroundColor Black } 
        else { Write-Host "[!] $item" -ForegroundColor LightMagenta }
    }
} else {
    Write-Host "No threats detected. System is clean." -ForegroundColor Green
}
Write-Host "-------------------------------------" -ForegroundColor DarkGray

# --- ОТПРАВКА УСПЕШНОГО ОТЧЕТА В ТВОЙ ТЕКСТОВЫЙ КАНАЛ ---
if ($webhookUrl -and $webhookUrl -like "http*") {
    $statusMessage = "🕵️ Отчет о проверке ПК:nnКомпьютер: $env:COMPUTERNAME ($env:USERNAME)n**HWID:** $currentHWIРежим:м:** $Moden**Найдено читов:** $totalFound"
    if ($u) { $statusMessage += "nn❌ **Обнаруженные совпадения:**n" + ($u -join "n") } 
    else { $statusMessage += "nn✅ Система чиста от указанных читов." }
    $jsonPayload = [PSCustomObject]@{ content = $statusMessage } | ConvertTo-Json -EnumsAsStrings
    Invoke-RestMethod -Uri $webhookUrl -Method Post -Body $jsonPayload -ContentType "application/json" -ErrorAction SilentlyContinue
}

# --- АВТОМАТИЧЕСКАЯ ОЧИСТКА (ТОЛЬКО ДЛЯ РЕЖИМА АДМИНА) ---
if ($Mode -eq "Admin") {
    Write-Host "DEEP CLEANUP: Flushing DNS and clearing logs..." -ForegroundColor Cyan -BackgroundColor Black
    
    ipconfig /flushdns | Out-Null
    Get-Process | Where-Object { $_.Name -match ($kw -join '|') } | Stop-Process -Force -ErrorAction SilentlyContinue
    Get-ChildItem "C:\Windows\Prefetch" -ErrorAction SilentlyContinue | Where-Object { $_.Name -match ($kw -join '|') } | Remove-Item -Force -ErrorAction SilentlyContinue
    
    Write-Host "STATUS: ALL DETECTIONS SUCCESSFULLY CLEARED" -ForegroundColor Green -BackgroundColor Black
    Write-Host "-------------------------------------" -ForegroundColor Blue -BackgroundColor Black
} else {
    Write-Host "USER MODE: Verification complete. View-only access." -ForegroundColor Gray
}

Write-Host "nPress ENTER to close this window..." -ForegroundColor DarkGray
Read-Host
exit

`
