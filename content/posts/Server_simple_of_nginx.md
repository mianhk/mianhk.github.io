+++
title = "服务器-Nginx基础配置"
date = "2018-01-24T20:50:05+08:00"
categories = ["服务器"]
tags = ["后台开发", "Linux", "Nginx"]
description = ""
+++

### 服务器-Nginx基础配置
#### nginx.conf文件结构
Nginx的默认配置文件为：`nginx.conf`，文件一共由三个部分组成，分别为：`全局块、events块、http块`在`http块`中，包含http全局块，多个server块。在每个`server块`中，可以包含多个server块和location块。

同一模块中嵌套的配置块。各个之间不存在次序关系，也就是是同时生效的。另外，在高一等级的配置可能会被更内层括号内的设置覆盖，这个其实跟我们的继承或者函数中差不多。

* 全局块：（从配置文件开始到events的一部分）主要影响Nginx服务器整体运行的配置指令 ，顾名思义，能够作用于全局。
* evevts块：主要影响Nginx服务器与用户的网络连接。这部分对Nginx服务器性能影响较大。
* http块：代理、缓存和日志定义等绝大部分功能和第三方模块的配置都在这部分。由于http块包括server块，这里用http全局块表示不包含server块的部分。
* server块：和“虚拟主机”密切联系。利用虚拟主机技术可以避免为每一个要用运行的网站提供单独的Nginx服务器，也不需要为每个网站对应一组nginx进程。一个http块中可以包含多个server块，每个server块相当于一个虚拟主机，它内部可以有多台主机联合提供服务，一起对外提供在逻辑上的一组服务（或网站）。server全局块一般配置的是：虚拟主机的监听配置和本虚拟主机的名称和IP配置。
* location块：location块其实是server块的一个指令，主要作用是：基于Nginx服务器接收到的字符串，对除虚拟主机名称外的字符串进行匹配，对特定的请求进行处理、地址定向、数据缓存和应答控制等功能。

#### 详细配置分析
接下来是一个详细解释的配置的设置
```
                                     #全局块开始
user user [group];                       #可以开启nginx服务的用户名user和所对应的group（可选）
#user nobody nobody;         #注释或者nobody可以表示任何人都能启动
worker_processes number|auto;               #开启的工作进程的数量，auto则会根据系统自动
pid /run/nginx.pid;                  #存储进程pid的文件，记得不止要加上路径，还要加上文件名，并且开启服务的用户需要对该文件有权限

events {                             #events块
    worker_connections 768;          #每一个工作进程能开启的最大连接个数：总的连接个数total=worker_processes*worker_connections
    # accept_mutex on;     #设置网络连接的序列化，解决“惊群”的问题（当一个网络连接到来时，多个睡眠进程被唤醒，影响系统性能）
    # multi_accept on;  #允许接受多个网络连接
    #use method;  #时间驱动模型的选择:select|poll|kqueue|epoll|rtsig|/dev/poll|eventport
}

http {                               #http块

    ##
    # Basic Settings
    ##

    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;   #连接超时时间
    #keepalive_requests number; #单连接请求数上限
    types_hash_max_size 2048;
    # server_tokens off;

    # server_names_hash_bucket_size 64;
    # server_name_in_redirect off;

    include /etc/nginx/mime.types;   #MIME-types存储了媒体资源的类型
    default_type application/octet-stream; #处理前端请求的MIME类型，可在http、server、location中定义

    ##
    # SSL Settings
    ##

    ssl_protocols TLSv1 TLSv1.1 TLSv1.2; # Dropping SSLv3, ref: POODLE
    ssl_prefer_server_ciphers on;

    ##
    # Logging Settings
    ##

    access_log /var/log/nginx/access.log;  # 日志存放文件名，该指令可以在全局块、http块和server块中，作用域不同
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

    include /etc/nginx/conf.d/*.conf;   # include 引入配置文件，支持相对路径
    include /etc/nginx/sites-enabled/*;
}


```
