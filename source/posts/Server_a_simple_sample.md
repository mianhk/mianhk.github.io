+++
title = "服务器-Nginx-一个简单的例子"
date = "2018-01-24T22:41:26+08:00"
categories = "服务器"
tags = ["后台开发", "Linux", "Nginx"]
description = ""
+++

### 服务器-Nginx-一个简单的例子
直接贴一个几经磨难的简单的例子吧，虽然简单，但是有些不理解的地方，就出了很多错，但是因为这些错误，在对nginx理解稍微深刻了那么一点点的同时，对Linux的操作好像也有了一点进步啊。才知道为什么大家的命令都那么长，而我总是一步步慢慢的来了，一方面不熟，另一方面确实操作的不够多啊。

#### 配置细节
```
user mianhk;
worker_processes 3;
pid /run/nginx.pid;

events {
    use epoll;
    #worker_connections 768;
    worker_connections 768;
    # multi_accept on;
}

http {

    ##
    # Basic Settings
    ##

    sendfile on;
    #tcp_nopush on;
    #tcp_nodelay on;
    keepalive_timeout 65;
    types_hash_max_size 2048;
    # server_tokens off;

    # server_names_hash_bucket_size 64;
    # server_name_in_redirect off;

    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    ##
    # SSL Settings
    ##

    #ssl_protocols TLSv1 TLSv1.1 TLSv1.2; # Dropping SSLv3, ref: POODLE
    #ssl_prefer_server_ciphers on;

    ##
    # Logging Settings
    ##

    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;

    ##
    # Gzip Settings
    ##

    gzip on;
    gzip_disable "msie6";

    # gzip_vary on;
    # gzip_proxied any;
    # gzip_comp_level 6;
    # gzip_buffers 16 8k;
    # gzip_http_version 1.1;
    # gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;

    ##
    # Virtual Host Configs
    ##
    ## 配置虚拟主机1
    server {
        listen        8081;   #监听端口
        server_name   myServer1;
        access_log  var/myweb/server1/log/access_log;  #配置日志存放路径
        error_page 404 /404.thml;   # 错误界面

        location /server1/location1 { #配置/server1/location1请求的location
            root /var/myweb;
            index index.svr1-loc1.htm;
        }
        location /server1/location2 {  #配置/server1/location2请求的location
            root /var/myweb;
            index index.svr1-locl2.htm;
        }
    }

    server {   #配置虚拟主机myServer2
        listen     8082;
        server_name 192.168.1.31;
        access_log var/myweb/server2/log/access_log;
        error_page 404 /404.thml;  #对错误页面定向

        location /server2/location1 {
            root /var/myweb;
            index index.svr2-loc1.htm;
        }
        location /svr2/loc2 {
            alias /myweb/server2/location2/;  #对location的URI进行更改
            index index.svr2-locl2.htm;
        }
        location = /404.html {  #配置错误页面转向
            root /var/myweb;
            index 404.html;
        }
    }
    #include /etc/nginx/conf.d/*.conf;
    #include /etc/nginx/sites-enabled/*;
}

```

#### 结果
在浏览器中输入：`http://111.230.231.95:8081/server1/location1/`![](https://blog-1252063226.cosbj.myqcloud.com/server/002001.jpg?raw=true)
输入`http://111.230.231.95:8082/server2/location1/`显示：
![](https://blog-1252063226.cosbj.myqcloud.com/server/002002.jpg?raw=true)

#### 出现的问题分析
* root目录的位置：
  原来root的目录虽然写的是/var/myweb，但是实际发现位置是 在`/usr/share/nginx`下面，所以需要拷过去，具体这个位置是在哪里设置的，因为已经把所有其他的include都关掉了，所以可能是ubuntu下安装之后的默认目录，就像默认监听的80端口的页面其实在`var/www/html`下面一样。 导致出了各种莫名其妙的错误啊:
```
root@VM-95-58-ubuntu:/etc/nginx# systemctl status nginx.service
● nginx.service - A high performance web server and a reverse proxy server
   Loaded: loaded (/lib/systemd/system/nginx.service; enabled; vendor preset: enabled)
   Active: failed (Result: exit-code) since Wed 2018-01-24 22:05:09 CST; 1s ago
  Process: 32576 ExecStop=/sbin/start-stop-daemon --quiet --stop --retry QUIT/5 --pidfile /run/nginx.pid (code
  Process: 21311 ExecStart=/usr/sbin/nginx -g daemon on; master_process on; (code=exited, status=0/SUCCESS)
  Process: 3307 ExecStartPre=/usr/sbin/nginx -t -q -g daemon on; master_process on; (code=exited, status=1/FAI
 Main PID: 21314 (code=exited, status=0/SUCCESS)

Jan 24 22:05:09 VM-95-58-ubuntu systemd[1]: Starting A high performance web server and a reverse proxy server.
Jan 24 22:05:09 VM-95-58-ubuntu nginx[3307]: nginx: [emerg] open() "/usr/share/nginx/var/myweb/server1/log/acc
Jan 24 22:05:09 VM-95-58-ubuntu nginx[3307]: nginx: configuration file /etc/nginx/nginx.conf test failed
Jan 24 22:05:09 VM-95-58-ubuntu systemd[1]: nginx.service: Control process exited, code=exited status=1
Jan 24 22:05:09 VM-95-58-ubuntu systemd[1]: Failed to start A high performance web server and a reverse proxy
Jan 24 22:05:09 VM-95-58-ubuntu systemd[1]: nginx.service: Unit entered failed state.
Jan 24 22:05:09 VM-95-58-ubuntu systemd[1]: nginx.service: Failed with result 'exit-code'.
```

* 另一个就是关于config文件的格式，一定要仔细写，需要加分号，然后就是最后的`/`，对于nginx的配置来说，是意义重大的，后面可能会说到这个问题，但是现在还是要写上。
* 刚刚测试，好像发现这里还有其他的问题，比如我的location2好像打不开啊，尴尬，明天再看看出了什么问题。。

