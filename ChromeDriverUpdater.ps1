$ProgressPreference = 'SilentlyContinue'
$chromedriverLocation = "path\to\chromedriver.exe"
$ver = (Get-ItemProperty "C:\Program Files\Google\Chrome\Application\Chrome.exe").VersionInfo.FileVersion
$trimming = $ver | Select-String -Pattern '^(\d*.){2}\d*'
$trimmed = $trimming.Matches[0].Value
$url = "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_" + $trimmed
$cVer = (iwr $url).Content
$url2 = "https://chromedriver.storage.googleapis.com/" + $cVer + "/chromedriver_win32.zip"
Invoke-WebRequest -uri $url2 -outfile $env:USERPROFILE\Downloads\chromedriver_win32.zip
Expand-Archive -LiteralPath "$env:USERPROFILE\Downloads\chromedriver_win32.zip" -DestinationPath "$env:USERPROFILE\Downloads\chromedriver_win32" -Force
Move-Item -Path "$env:USERPROFILE\Downloads\chromedriver_win32\chromedriver.exe" -Destination $chromedriverLocation -Force

Remove-Item -Path "$env:USERPROFILE\Downloads\chromedriver_win32.zip" -Force
Remove-Item -LiteralPath "$env:USERPROFILE\Downloads\chromedriver_win32" -Force -Recurse

