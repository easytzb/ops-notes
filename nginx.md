###我们一直编译进去但从来没用功能 stub_status

    location /nginx_status {
      # copied from http://blog.kovyrin.net/2006/04/29/monitoring-nginx-with-rrdtool/
      stub_status on;
      access_log   off;
      allow SOME.IP.ADD.RESS;
      deny all;
    }

    Active connections: 291
    server accepts handled requests
    16630948 16630948 31070465
    eading: 6 Writing: 179 Waiting: 106

###变量
* set为ngx_rewrite 模块的配置指令
* nginx变量以$开始，支持变量插值（variable interpolation，即set $a "hello";set $b "$a, $a";）

ngx_echo模块的echo指令也支持变量插值(set $a "hello";echo $a;)，一个指令是否支持变量插值，由它所在的模块决定。

ngx_geo demo

    geo  $geo  { # the variable created is $geo, the variables of $geo is depended on the IP of client.
      default          0;
      127.0.0.1/32     2;
      192.168.1.0/24   1;
      10.1.0.0/16      1;
    }

变量不创建就使用，则nginx无法启动。其创建全局的，但赋值后有其边界：至少是以请求为边界，即这次请求对变量的赋值，不会影响下次请求变量赋值。
Nginx常用的阶段按先后顺序有：rewrite阶段，access阶段，content阶段等


###SSL配置
生成RSA密钥的方法

    openssl genrsa -des3 -out privkey.pem 2048
这个命令会生成一个2048位的密钥，同时有一个des3方法加密的密码，如果你不想要每次都输入密码，可以改成：

    openssl genrsa -out privkey.pem 2048
建议用2048位密钥，少于此可能会不安全或很快将不安全。

    openssl req -new -x509 -key privkey.pem -out cacert.pem -days 1095

    server
    {
        listen 443 ssl;
        ssl on;
        ssl_certificate /var/www/sslkey/cacert.pem;
        ssl_certificate_key /var/www/sslkey/privkey.pem;
        server_name 192.168.1.1;
        index index.html index.htm index.php;
        root /var/www/test;
    }
