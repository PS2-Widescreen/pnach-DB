@echo off
del ONLY_MASTERCODE_MISSING.txt
del ONLY_MASTERCODE_MISSING2.txt
for %%a in (PNACH_WITH_ID\*.pnach) do if not exist ..\OPL-Widescreen-Cheats\CHT\%%~na.cht echo %%~na>>ONLY_MASTERCODE_MISSING.txt && echo %%~na
type ONLY_MASTERCODE_MISSING.txt | busybox tr "," "\n" >ONLY_MASTERCODE_MISSING2.txt && echo replaced comma with \r\n || echo error replacing comma with \r\n
type ONLY_MASTERCODE_MISSING2.txt | busybox unix2dos | busybox sort >ONLY_MASTERCODE_MISSING.txt


del ONLY_MASTERCODE_MISSING2.txt