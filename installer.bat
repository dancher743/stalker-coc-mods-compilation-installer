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
  
  mkdir settings_temp
  for %%S in (%settings_files%) do (
   if exist !orig_settings_file_path!\%%S move !orig_settings_file_path!\%%S !temp_settings_file_path!\%%S
  )
  
  if exist gamedata rd /S /Q gamedata
  ren !mod_folder! gamedata

  for %%S in (%settings_files%) do (
   if exist !temp_settings_file_path!\%%S (
    if not exist !orig_settings_file_path! mkdir !orig_settings_file_path!
	move !temp_settings_file_path!\%%S !orig_settings_file_path!\%%S
   )
  )
  rd /S /Q settings_temp
  
  echo Done^^!
  echo.
  
  goto :break
 )
)

:break

SETLOCAL DisableDelayedExpansion

pause
