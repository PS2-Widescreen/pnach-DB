@echo off
REM CLEANUP
del ONLY_MASTERCODE_MISSING.txt
del ONLY_MASTERCODE_MISSING2.txt

for %%a in (PNACH_WITH_ID\*.pnach) do (
if not exist "..\OPL-Widescreen-Cheats\CHT\%%~na.cht" echo %%~na>>ONLY_MASTERCODE_MISSING.txt
if exist "..\Bare-Mastercodes-bin\MASTERCODES\%%a.cht" echo -- %a - available mastercode
)

type ONLY_MASTERCODE_MISSING.txt | busybox tr "," "\n" >ONLY_MASTERCODE_MISSING2.txt && echo( || echo error replacing comma with \r\n
type ONLY_MASTERCODE_MISSING2.txt | busybox unix2dos | busybox sort | busybox uniq >ONLY_MASTERCODE_MISSING.txt

del ONLY_MASTERCODE_MISSING2.txt
if not exist gamename.csv wget -q --show-progress https://github.com/israpps/HDL-Batch-installer/raw/main/Database/gamename.csv -O gamename.csv
for /f "delims=" %%a in (ONLY_MASTERCODE_MISSING.txt) do findstr "%%a" gamename.csv >nul && findstr "%%a" gamename.csv>>ONLY_MASTERCODE_MISSING2.txt || echo %%a;UNKNOWN TITLE>>ONLY_MASTERCODE_MISSING2.txt

type ONLY_MASTERCODE_MISSING2.txt > ONLY_MASTERCODE_MISSING.txt
del  ONLY_MASTERCODE_MISSING2.txt
echo done

pause