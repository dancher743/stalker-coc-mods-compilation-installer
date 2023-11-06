echo off

set settings_files=atmosfear_default_settings.ltx atmosfear_options.ltx axr_options.ltx localization.ltx

SETLOCAL EnableDelayedExpansion

for /D %%G in (*) do (
 set "folder=%%G"
 set "result=!folder:~0,28!"
 
 if !result! == stalker-coc-mods-compilation (  
  set "mod_folder=%%G"

  echo.
  echo !mod_folder!
  echo Installing...
  
  set orig_settings_file_path=gamedata\configs
  set temp_settings_file_path=settings_temp
  
  for %%S in (%settings_files%) do (
   if exist !orig_settings_file_path!\%%S (
    if not exist !temp_settings_file_path! mkdir !temp_settings_file_path!
	move !orig_settings_file_path!\%%S !temp_settings_file_path!\%%S >nul
   )
  )
  
  if exist gamedata rd /S /Q gamedata
  ren !mod_folder! gamedata

  for %%S in (%settings_files%) do (
   if exist !temp_settings_file_path!\%%S (
    if not exist !orig_settings_file_path! mkdir !orig_settings_file_path!
	move !temp_settings_file_path!\%%S !orig_settings_file_path!\%%S >nul
   )
  )
  if exist !temp_settings_file_path! rd /S /Q !temp_settings_file_path!

  echo Done^^!
  echo.
  
  goto :break
 )
)

:break

SETLOCAL DisableDelayedExpansion

pause
