echo off

set settings_files=setting_1 setting_2 setting_3

SETLOCAL EnableDelayedExpansion

echo.

for /D %%G in (*) do (
 set "folder=%%G"
 set "result=!folder:~0,28!"
 
 if !result! == stalker-coc-mods-compilation (  
  set "mod_folder=%%G"

  echo !mod_folder!
  echo Installing...
  
  mkdir settings_temp
  for %%S in (%settings_files%) do (
   if exist gamedata\%%S.txt move gamedata\%%S.txt %cd%\settings_temp >nul
  )

  if exist gamedata rd /S /Q gamedata
  ren !mod_folder! gamedata
  
  for %%S in (%settings_files%) do (
   if exist %cd%\settings_temp\%%S.txt move %cd%\settings_temp\%%S.txt gamedata\%%S.txt >nul
  )
  rd /S /Q settings_temp
  
  echo Done^^!
  goto :break
 )
)

:break

echo.

SETLOCAL DisableDelayedExpansion

pause
