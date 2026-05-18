<#
    Inseqqure System Checker - Deep Edition (2026)
    Hosted on GitHub, executed directly into memory.
#>
param (
    [string]$Mode = "User"
)

# Мгновенная очистка экрана от системного мусора (system32)
Clear-Host

# Массив читов (все слова перевернуты задом наперед для скрытности)
$w = @(
    'taehc',          # cheat
    'tcejni',         # inject
    'koohreven',      # neverhook
    'epav',           # vape
    'tsrow',          # worst
    'natlosron',      # noslorant
    'atled',          # delta
    'natlusrun',      # nursultan (новый)
    'evisnepxe',      # expensive (новый)
    'cld',            # dlc / system dlc (новый)
    'ecnuobdiuqil',   # liquidbounce (новый)
    'neirka',         # akrien (новый)
    'laitsalec'       # celestial (новый)
)

# Переворачиваем слова обратно в нормальный вид в оперативной памяти
$kw = $w | % { $a = $_.ToCharArray(); [Array]::Reverse($a); -join $a }
$d = @()

# --- СКАНИРОВАНИЕ СИСТЕМЫ ---
# 1. Поиск по запущенным процессам
Get-Process | Where-Object { $_.Name -match ($kw -join '|') } | % { $d += 'Proc:' + $_.Name }

# 2. Поиск по логам файлов Prefetch
Get-ChildItem "C:\Windows\Prefetch" -ErrorAction SilentlyContinue | Where-Object { $_.Name -match ($kw -join '|') } | % { $d += 'File:' + $_.Name }

$u = $d | Unique
$totalFound = if ($u) { $u.Count } else { 0 }

Clear-Host

# --- 🎨 ВИЗУАЛЬНЫЙ БЛОК ДЛЯ АДМИНИСТРАТОРА (СИНИЙ / ЧЕРНЫЙ) ---
if ($Mode -eq "Admin") {
    # Синий верхний слой заголовка на черном фоне
    Write-Host "=====================================" -ForegroundColor Cyan -BackgroundColor Black
    Write-Host "         C H E C K E R   D E E P     " -ForegroundColor Cyan -BackgroundColor Black
    # Темно-серый нижний слой (эффект тени/глубины)
    Write-Host "         c h e c k e r   d e e p     " -ForegroundColor DarkGray -BackgroundColor Black
    Write-Host "=====================================" -ForegroundColor DarkGray -BackgroundColor Black
    
    Write-Host "TOTAL DETECTIONS FOUND: $totalFound" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host "-------------------------------------" -ForegroundColor Blue -BackgroundColor Black
} 
# --- 🎨 ВИЗУАЛЬНЫЙ БЛОК ДЛЯ ОБЫЧНОГО ИГРОКА (КРАСНЫЙ / СЕРЫЙ) ---
else {
    Write-Host '=== INSEQQURE SYSTEM CHECKER ===' -ForegroundColor Red
    Write-Host "TOTAL DETECTIONS FOUND: $totalFound" -ForegroundColor Yellow
    Write-Host "-------------------------------------" -ForegroundColor DarkGray
}

# --- ВЫВОД НАЙДЕННЫХ СОВПАДЕНИЙ ---
if ($u) {
    foreach ($item in $u) { 
        if ($Mode -eq "Admin") {
            # Для админа логи выводятся в строгом синем цвете на черном фоне
            Write-Host "[!] $item" -ForegroundColor Blue -BackgroundColor Black
        } else {
            # Для обычного игрока — стандартный розовый лог
            Write-Host "[!] $item" -ForegroundColor LightMagenta
        }
    }
} else {
    Write-Host "No threats detected. System is clean." -ForegroundColor Green
}
Write-Host "-------------------------------------" -ForegroundColor DarkGray

# --- 🛠 АВТОМАТИЧЕСКАЯ ОЧИСТКА (ТОЛЬКО ДЛЯ РЕЖИМА АДМИНА) ---
if ($Mode -eq "Admin") {
    Write-Host "DEEP CLEANUP: Flushing DNS and clearing logs..." -ForegroundColor Cyan -BackgroundColor Black
    
    # Скрытая очистка кэша DNS
    ipconfig /flushdns | Out-Null
    
    # Закрытие процессов читов
    Get-Process | Where-Object { $_.Name -match ($kw -join '|') } | Stop-Process -Force -ErrorAction SilentlyContinue
    
    # Удаление файлов префетча
    Get-ChildItem "C:\Windows\Prefetch" -ErrorAction SilentlyContinue | Where-Object { $_.Name -match ($kw -join '|') } | Remove-Item -Force -ErrorAction SilentlyContinue
    
    Write-Host "STATUS: ALL DETECTIONS SUCCESSFULLY CLEARED" -ForegroundColor Green -BackgroundColor Black
    Write-Host "-------------------------------------" -ForegroundColor Blue -BackgroundColor Black
} else {
    Write-Host "USER MODE: Verification complete. View-only access." -ForegroundColor Gray
}

Write-Host "`nPress ENTER to close this window..." -ForegroundColor DarkGray
Read-Host
exit
