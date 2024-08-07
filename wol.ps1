# WOL用のPowerShellスクリプト

# ターゲットのMACアドレスを指定
# $macAddress = "XX:XX:XX:XX:XX:XX"

# MACアドレスをバイト配列に変換
$macBytes = ($macAddress -split ':') | ForEach-Object { [convert]::ToByte($_, 16) }

# WOLパケットを作成
$packet = @(0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF) + ($macBytes * 16)

# WOLパケットを送信するUDPクライアントを作成
$udpClient = New-Object System.Net.Sockets.UdpClient
$udpClient.Connect([System.Net.IPAddress]::Broadcast, 9)

# WOLパケットを送信
$udpClient.Send($packet, $packet.Length)

# UDPクライアントを閉じる
$udpClient.Close()

Write-Host "WOLパケットを送信しました: $macAddress"
