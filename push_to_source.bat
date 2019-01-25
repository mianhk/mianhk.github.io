echo 切换目录
f:
cd \blog\mianhk.github.io

title GIT提交批处理到blog——余国聪
color 16

echo;
echo;

echo 开始提交代码到本地仓库
echo 当前目录是：%cd%

echo;
echo;
echo 开始识别当前git的版本
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
git --version
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo;
echo;

echo 开始添加变更
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
git add -A .
echo 执行结束！
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

echo;
echo 提交变更到本地仓库
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
set declation=%date:~0,4%%date:~5,2%%date:~8,2%
git commit -m "%declation%同步博客"
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

echo;
echo 将变更情况提交到远程git服务器source
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
git push origin source
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

echo;
echo 批处理执行完毕！
echo;

pause