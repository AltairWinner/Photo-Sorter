@ECHO OFF
setlocal enabledelayedexpansion

echo [%TIME%] [Sorter] Starting Sorter.

if "%1" EQU "" (
	echo [%TIME%][Sorter] No parameters detected, going to default paths...

	set sourceRoot=%~dp0
	set targetRoot=%~dp0
	)

if "%1" NEQ "" (
	set sourceRoot=%1
	
	if "%2" EQU "" (
		echo [%TIME%][Sorter] No second parameter detected, assuming %sourceRoot% as target folder.
		set targetRoot=%sourceRoot%
	)	
)

if "%2" NEQ "" set targetRoot=%2
	
echo [%TIME%][Sorter] Start Folder: %sourceRoot%
echo [%TIME%][Sorter] Target Folder: %targetRoot%

set fileMask=*.jpg,*.png,*.raf,*.nec,*.dng

echo [%TIME%][Sorter] Sorting...
for /r "%sourceRoot%" %%a in (%fileMask%) do (
	echo [%TIME%][Sorter] Processing [%%~ta] %%~fa
	for /f "tokens=1-3 delims=. " %%f in ("%%~ta") do (
		set DD=%%f
		set MM=%%g
		set YYYY=%%h
	)
	set targetFolder=!YYYY! !MM! !DD!
	if not exist "%targetRoot%\!targetFolder!" md "%targetRoot%\!targetFolder!"
	move "%%~fa" "%targetRoot%\!targetFolder!"
)

echo [%TIME%][Sorter] Task finished successfuly.
pause