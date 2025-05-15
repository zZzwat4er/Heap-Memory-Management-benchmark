@echo off
setlocal enabledelayedexpansion

for /d %%d in ("Experiment *") do (
    if exist "%%d\test.bat" (
        echo Running test.bat in %%d
        pushd "%%d"
        call test.bat
        popd
    ) else (
        echo test.bat not found in %%d
    )
    for /l %%i in (1,1,80) do @echo ^|^=^|>nul
)