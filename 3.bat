start /min /w mshta vbscript:setTimeout("window.close()",1000)
echo The InputValue is %1
set name=%1
echo %name%
start /d "D:\Program Files\Sublime Text 3"   sublime_text.exe  "F:\github\mianhk\blog\source\_posts\%name%.md"
pause