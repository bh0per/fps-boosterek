@echo off
REM --- Skrypt optymalizujący komputer pod gry ---

REM --- Zmniejszenie opóźnienia myszy ---
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 2 /f
REM Opis: Zmniejsza opóźnienie myszy, co może poprawić responsywność w grach.

REM --- Wyłączenie efektów wizualnych ---
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f
REM Opis: Redukuje zużycie zasobów poprzez wyłączenie niektórych efektów wizualnych systemu.

REM --- Wyłączenie indeksowania ---
sc config "wsearch" start= disabled
net stop "wsearch"
REM Opis: Wyłącza usługę indeksowania, która może zajmować zasoby systemowe.

REM --- Wyłączenie usługi Windows Update ---
sc config "wuauserv" start= disabled
net stop "wuauserv"
REM Opis: Tymczasowo wyłącza automatyczne aktualizacje systemu, aby uniknąć zakłóceń podczas grania.

REM --- Ustawienie priorytetu dla gry ---
set /p GamePath="Podaj ścieżkę do gry (np. C:\ŚcieżkaDoGry\Game.exe): "
wmic process where name="%GamePath%" CALL setpriority "high"
REM Opis: Ustawia wyższy priorytet procesu gry, co może poprawić wydajność.

REM --- Wyłączenie niepotrzebnych usług ---
sc config "Superfetch" start= disabled
net stop "Superfetch"
REM Opis: Wyłącza usługi, które mogą być zbędne podczas grania.

REM --- Wyłączenie konsolidatora pamięci ---
sc config "MemoryCompression" start= disabled
net stop "MemoryCompression"
REM Opis: Wyłącza konsolidator pamięci, który może działać w tle.

REM --- Ustawienie priorytetu czasu rzeczywistego dla gry ---
cmd.exe /c start "NazwaGry" /Realtime "%GamePath%"
REM Opis: Ustawia priorytet czasu rzeczywistego dla procesu gry.

REM --- Zakończenie eksploratora Windows ---
taskkill /f /im explorer.exe
REM Opis: Zamyka procesy eksploratora Windows podczas uruchamiania gry.

REM --- Uruchomienie gry ---
start "NazwaGry" "%GamePath%"
REM Opis: Uruchamia grę.

REM --- Poczekaj na zakończenie gry ---
timeout /t 60 /nobreak
REM Opis: Oczekuje przez 60 sekund (możesz dostosować), aby dać czas grze na uruchomienie.

REM --- Przywrócenie eksploratora Windows ---
start explorer.exe
REM Opis: Przywraca eksploratora Windows po zakończeniu gry.

REM --- Przywrócenie usług i efektów wizualnych ---
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 10 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 3 /f
sc config "wsearch" start= delayed-auto
sc config "wuauserv" start= delayed-auto
sc config "Superfetch" start= delayed-auto
sc config "MemoryCompression" start= automatic
REM Opis: Przywraca ustawienia do domyślnych po zakończeniu gry.

echo.
echo Optymalizacja zakończona.
REM --- cc by:bh0per ---
