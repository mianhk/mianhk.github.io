@echo off
echo clean
echo Please wait
hexo clean
start /min /w mshta vbscript:setTimeout("window.close()",1200)
hexo g -d
pause