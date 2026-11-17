@echo off
title Job Circular App - Mobile Simulator Launcher
cd /d "%~dp0\preview"

if not exist "JobAppLauncher.exe" (
    echo Compiling simulator launcher...
    "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\csc.exe" /target:winexe /r:System.Windows.Forms.dll /r:System.Drawing.dll /out:JobAppLauncher.exe Server.cs
)

echo Starting Mobile App Simulator at http://localhost:5060/...
start "" "JobAppLauncher.exe"
exit
