@echo off
SETLOCAL

REM Define the paths for Roaming and Local nvim-data directories
SET SWAP=%LOCALAPPDATA%\nvim-datanvim-data\swap

REM Check and remove the Local nvim-data directory
IF EXIST "%SWAP%" (
    ECHO Deleting Local nvim-data swap directory...
    RMDIR /S /Q "%SWAP%"
) ELSE (
    ECHO Local nvim-data swap directory not found.
)

ECHO Done.
ENDLOCAL

pause
