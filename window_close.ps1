# FortiClientのウィンドウを最小化するスクリプト
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Window {
    [DllImport("user32.dll")]
    [return: MarshalAs(UnmanagedType.Bool)]
    public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
    [DllImport("user32.dll")]
    public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);
}
"@

# 最大で60秒（1分）実行する
$maxDuration = 60
$interval = 5
$endTime = (Get-Date).AddSeconds($maxDuration)

while ((Get-Date) -lt $endTime) {
    # FortiClientのウィンドウを探す
    $hwnd = [Window]::FindWindow("FortiClient", $null)
    if ($hwnd -ne [IntPtr]::Zero) {
        [Window]::ShowWindow($hwnd, 2) # 2は最小化を意味します
    }
    Start-Sleep -Seconds $interval
}
