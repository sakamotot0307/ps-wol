@echo off
rem @if not “%~0″==”%~dp0.\%~nx0″ start /min cmd /c,”%~dp0.\%~nx0” %* & goto :eo

reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{6BBF4252-CB6B-4E0B-9E5B-1719B7934917}_is1" >nul 2>&1
if %errorlevel% equ 0 (
    echo CubePDFは既にインストールされています。
    pause
    exit /b
)

net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~0' -Verb runAs -WindowStyle Minimized"
    exit /b
)

%~dp0cubepdf-4.2.0-x64.exe /lang=japanese /verysilent /sp- /nocancel /norestart /suppressmsgboxes /nolaunch

pause

rem [資産管理] - [アプリケーション一覧] - [ソフトウェア配布]より、「追加」ボタンをクリック
rem https://www.netattest.com/zero-touch-certificate-distributionsoliton-keymanager-skysea-2024_tec_sol
