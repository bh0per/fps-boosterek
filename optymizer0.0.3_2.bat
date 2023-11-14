@echo off
REM --- Skrypt optymalizujący komputer pod gry ---

echo Uzyskiwanie uprawnień administratora...
powershell -Command "Start-Process '%0' -Verb RunAs"; exit

REM --- Funkcje optymalizacyjne ---
set /p GamePath="Podaj ścieżkę do gry (np. C:\ŚcieżkaDoGry\Game.exe): "
REM Pozostała część skryptu optymalizującego...

REM --- Optymalizacja dysku SSD ---
fsutil behavior set disabledeletenotify 0

REM --- Zmiana priorytetu procesu gry na wyższy ---
wmic process where name="%GamePath%" CALL setpriority "high"

REM --- Włączenie trybu pełnoekranowego dla gry ---
reg add "HKCU\Software\GameCompany\GameName" /v Fullscreen /t REG_DWORD /d 1 /f

REM --- Optymalizacja ustawień karty graficznej (przykład dla kart NVIDIA) ---
nvidia-smi -ac 2505,875

REM --- Wyłączanie zbędnych usług ---
sc config "sysmain" start= disabled
net stop "sysmain"

REM --- Optymalizacja ustawień TCP/IP ---
netsh int tcp set global autotuninglevel=normal

REM --- Skrypt przywracający domyślne ustawienia ---

REM --- Przywracanie opóźnienia myszy ---
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 10 /f

REM --- Przywracanie efektów wizualnych ---
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 3 /f

REM --- Włączenie indeksowania ---
sc config "wsearch" start= delayed-auto
net start "wsearch"

REM --- Włączenie usługi Windows Update ---
sc config "wuauserv" start= delayed-auto
net start "wuauserv"

REM --- Przywracanie priorytetu dla gry ---
set /p GamePath="Podaj ścieżkę do gry (np. C:\ŚcieżkaDoGry\Game.exe): "
wmic process where name="%GamePath%" CALL setpriority "normal"

REM --- Włączenie konsolidatora pamięci ---
sc config "MemoryCompression" start= automatic
net start "MemoryCompression"

REM --- Zamykanie eksploratora Windows tylko, jeśli jest uruchomiony ---
tasklist /fi "imagename eq explorer.exe" | find /i "explorer.exe" > nul
if %errorlevel% equ 0 (
    taskkill /f /im explorer.exe
)

REM --- Uruchomienie gry ---
start "" "%GamePath%"
echo.
echo Przywracanie zakończone.
REM ---- cc:werbel ----
