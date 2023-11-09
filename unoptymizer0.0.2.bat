@echo off
REM --- Skrypt przywracający domyślne ustawienia ---

REM --- Przywrócenie opóźnienia myszy ---
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 10 /f
REM Opis: Przywraca domyślne opóźnienie myszy.

REM --- Przywrócenie efektów wizualnych ---
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 3 /f
REM Opis: Przywraca domyślne ustawienia efektów wizualnych systemu.

REM --- Włączenie indeksowania ---
sc config "wsearch" start= delayed-auto
net start "wsearch"
REM Opis: Przywraca usługę indeksowania.

REM --- Włączenie usługi Windows Update ---
sc config "wuauserv" start= delayed-auto
net start "wuauserv"
REM Opis: Przywraca automatyczne aktualizacje systemu.

REM --- Przywrócenie priorytetu dla gry ---
set /p GamePath="Podaj ścieżkę do gry (np. C:\ŚcieżkaDoGry\Game.exe): "
wmic process where name="%GamePath%" CALL setpriority "normal"
REM Opis: Przywraca domyślny priorytet czasu rzeczywistego dla procesu gry.

REM --- Włączenie niepotrzebnych usług ---
sc config "Superfetch" start= delayed-auto
net start "Superfetch"
REM Opis: Przywraca usługi, które mogą być używane przez system.

REM --- Włączenie konsolidatora pamięci ---
sc config "MemoryCompression" start= automatic
net start "MemoryCompression"
REM Opis: Przywraca konsolidator pamięci do ustawień domyślnych.

REM --- Przywrócenie eksploratora Windows ---
start explorer.exe
REM Opis: Przywraca eksploratora Windows po zakończeniu gry.

echo.
echo Przywracanie zakończone.
