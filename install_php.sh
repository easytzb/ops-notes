#!/bin/sh
#check $0 path
curDir=$(cd "$(dirname "$0")"; pwd);
if test "$curDir" != "/root" ; then export LANG="zh_CN.UTF-8"\
 && echo "Error：请将 $0 移到/root目录运行"\
 && exit 1; fi
#check /root/lamp
if test ! -e /root/lamp; then export LANG="zh_CN.UTF-8"\
 && echo "Error：软件包目录 /root/lamp 不存在，请检查"\
 && exit 1; fi
cd /root/lamp
if test ! -e /webser ; then mkdir -p /webser; fi
mysql55()
{
	
	cd /root/lamp\
 && if [ ! -e /usr/local/bin/cmake ]; then tar zxf cmake-2.8.7.tar.gz\
 && cd cmake-2.8.7\
 && ./configure\
 && make -j 16\
 && make install\
 && cd ../\
 && rm -rf ./cmake-2.8.7; fi\
 && (groupadd -f mysql; useradd -u 1001 -g mysql mysql; echo '1')\
 && tar zxf ./Percona-Server-5.5.21-rel25.1.tar.gz\
 && cd ./Percona-Server-5.5.21-rel25.1\
 && cmake . -DCMAKE_INSTALL_PREFIX=/webser/mysql55 -DWITH_READLINE=1 -DWITH_ZLIB=/usr/lib64 -DMYSQL_DATADIR=/webser/mysql55/var\
 && make -j 16\
 && make install\
 && cp -f /root/lamp/config/my55.cnf /webser/mysql55/my.cnf\
 && mkdir -p /webser/mysql55/var/\
 && if [ -e /etc/my.cnf ]; then mv /etc/my.cnf /etc/my.cnf.bak; fi\
 && cd /webser/mysql55/\
 && /webser/mysql55/scripts/mysql_install_db --user=mysql --defaults-file=/webser/mysql55/my.cnf\
 && cd /root/lamp/Percona-Server-5.5.21-rel25.1\
 && rm -rf /webser/mysql55/data\
 && chown -R mysql:mysql /webser/mysql55/var\
 && cd ..\
 && rm -rf ./Percona-Server-5.5.21-rel25.1\
 && cp -f /root/lamp/shell/startmysql /webser/startmysql\
 && cp -f /root/lamp/shell/stopmysql /webser/stopmysql\
 && chmod +x /webser/stopmysql\
 && sed -i "s/mysql51/mysql55/g" /webser/startmysql\
 &&  chmod +x /webser/startmysql\
 && /webser/startmysql
}

mysql51()
{
	cd /root/lamp\
 && (groupadd -f mysql; useradd -u 1001 -g mysql mysql; echo '1')\
 && tar zxf ./Percona-Server-5.1.62.tar.gz\
 && cd ./Percona-Server-5.1.62\
 && ./configure --prefix=/webser/mysql51 --with-extra-charsets=all --with-plugins=partition,ftexample,archive,csv,heap,innobase,innodb_plugin,myisam,myisammrg\
 && make -j 16\
 && make install\
 && cp -f /root/lamp/config/my.cnf /webser/mysql51/my.cnf\
 && mkdir -p /webser/mysql51/var/\
 && if [ -e /etc/my.cnf ]; then mv /etc/my.cnf /etc/my.cnf.bak; fi\
 && /webser/mysql51/bin/mysql_install_db\
 && chown -R mysql:mysql /webser/mysql51/var\
 && cd ..\
 && rm -rf ./Percona-Server-5.1.62\
 && cp -f /root/lamp/shell/startmysql /webser/startmysql\
 && cp -f /root/lamp/shell/stopmysql /webser/stopmysql\
 && chmod +x /webser/stopmysql\
 &&  chmod +x /webser/startmysql\
 && /webser/startmysql
}
mysql50()
{
	cd /root/lamp\
 && (groupadd -f mysql; useradd -u 1001 -g mysql mysql; echo '1')\
 && tar zxf ./mysql50.tar.gz\
 &&  mv ./mysql50 /webser/mysql50\
 && if [ -e /etc/my.cnf ]; then mv /etc/my.cnf /etc/my.cnf.bak; fi\
 && /webser/mysql50/bin/mysql_install_db\
 && chown -R mysql:mysql /webser/mysql50/data/\
 && cp -f /root/lamp/shell/startmysql /webser/startmysql\
 && cp -f /root/lamp/shell/stopmysql /webser/stopmysql\
 && chmod +x /webser/stopmysql\
 && sed -i "s/mysql51/mysql50/g" /webser/startmysql\
 &&  chmod +x /webser/startmysql\
 && /webser/startmysql
}
changeMysqlPwd()
{
	sleep 15;
	if [ -e /webser/mysql51/bin/mysql ]; then /webser/mysql51/bin/mysql -u root -e'use mysql;set password for root@"127.0.0.1"=password("QWERT!@#$%");set password for root@"localhost"=password("QWERT!@#$%");delete from db WHERE user="";delete from user WHERE password="";grant SELECT ON nrep.* to "nrep_ujff"@"127.0.0.1" identified by "w0aImima";
grant SELECT ON nrep.* to "nrep_ujff"@"192.168.%.%" identified by "w0aImima";flush privileges;'; elif [ -e /webser/mysql55/bin/mysql ]; then /webser/mysql55/bin/mysql -u root -e'use mysql;set password for root@"127.0.0.1"=password("QWERT!@#$%");set password for root@"localhost"=password("QWERT!@#$%");delete from db WHERE user="";delete from user WHERE password="";grant SELECT ON nrep.* to "nrep_ujff"@"127.0.0.1" identified by "w0aImima";grant SELECT ON nrep.* to "nrep_ujff"@"192.168.%.%" identified by "w0aImima";flush privileges;';fi
}
apache()
{
	cd /root/lamp\
 && tar zxf ./httpd-2.2.21.tar.gz\
 && cd ./httpd-2.2.21\
 && ./configure --prefix=/webser/httpd2 --enable-rewrite --enable-speling --enable-ssl LDFLAGS=-L/usr/lib64\
 && make -j 16\
 && make install\
 && cd ..\
 && rm -rf ./httpd-2.2.21\
 && mv /webser/httpd2/conf/httpd.conf /webser/httpd2/conf/old_httpd.conf\
 && cp /root/lamp/config/pw/httpd.conf /webser/httpd2/conf/httpd.conf	
}
nginx()
{
	cd /root/lamp\
 && tar zxf ./tengine-1.5.2.tar.gz\
 && tar zxf ./pcre-8.33.tar.gz\
 && yum install -y openssl openssl-devel\
 && cd ./tengine-1.5.2\
 && ./configure --prefix=/webser/nginx --with-pcre=/root/lamp/pcre-8.33 --group=www --user=www --with-http_stub_status_module --with-http_ssl_module \
 && make -j 16\
 && make install\
 && (groupadd -f www; useradd -u 1000 -g www www; echo '1')\
 && if [ ! -d /webser/logs ]; then mkdir /webser/logs; fi\
 && if [ ! -d /webser/logs/nginx/cronolog ]; then mkdir -p /webser/logs/nginx/cronolog; fi\
 && chown -R www:www /webser/logs\
 && cd ..\
 && rm -rf ./tengine-1.5.2\
 && rm -rf ./pcre-8.33\
 && cp -f /root/lamp/config/nginx.conf /webser/nginx/conf/nginx.conf\
 && cp -f /root/lamp/config/fcgi.conf /webser/nginx/conf/fcgi.conf 
}
varnish()
{
	cd /root/lamp\
 && if test ! -e /usr/local/lib/pkgconfig; then tar zxf pcre-8.33.tar.gz\
 && cd pcre-8.33\
 && ./configure\
 && make -j 16\
 && make install\
 && cd ../\
 && rm -rf ./pcre-8.33;fi\
 && export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig\
 && tar zxf varnish-3.0.2.tar.gz\
 && cd varnish-3.0.2\
 && ./autogen.sh\
 && ./configure --prefix=/webser/varnish\
 && make -j 16\
 && make check\
 && make install\
 && cd ../\
 && rm -rf varnish-3.0.2
}
ifstat()
{
	cd /root/lamp\
 && tar zxf ifstat-1.1.tar.gz\
 && cd ifstat-1.1\
 && ./configure\
 && make -j 16\
 && make install\
 && cd ../\
 && rm -rf ifstat-1.1
}
rsync3()
{
	cd /root/lamp\
 && tar zxf rsync-3.1.0.tar.gz\
 && cd rsync-3.1.0\
 && ./configure --prefix=/usr/local/rsync3\
 && make \
 && make install\
 && cd ../\
 && rm -rf rsync-3.1.0
}
baselib()
{
	cd /root/lamp\
 && tar zxf ./zlib-1.2.6.tar.gz\
 && cd ./zlib-1.2.6\
 && ./configure --prefix=/usr/local/zlib --libdir=/usr/lib64\
 && make -j 16\
 && make install\
 && cd ..\
 && rm -rf ./zlib-1.2.6\
 && tar zxf ./freetype-2.4.8.tar.gz\
 && cd ./freetype-2.4.8\
 && ./configure --prefix=/usr/local/freetype2 LDFLAGS=-L/usr/lib64\
 && make -j 16\
 && make install\
 && cd ..\
 && rm -rf ./freetype-2.4.8\
 && tar zxf ./jpeg-6b.tar.gz\
 && cd ./jpeg/src\
 && ./configure --prefix=/usr/local/jpeg-6 LDFLAGS=-L/usr/lib64\
 && mkdir -p /usr/local/jpeg-6/bin\
 && mkdir -p /usr/local/jpeg-6/man/man1\
 && make -j 16\
 && make install\
 && cd ../../\
 && rm -rf ./jpeg\
 && tar zxf ./libxml2-2.7.8.tar.gz\
 && cd ./libxml2-2.7.8\
 && ./configure --prefix=/usr/local/libxml2 LDFLAGS=-L/usr/lib64\
 && make -j 16\
 && make install\
 && cd ..\
 && rm -rf ./libxml2-2.7.8\
 && tar zxf ./libiconv-1.14.tar.gz\
 && cd ./libiconv-1.14\
 && ./configure --prefix=/usr/local/libiconv LDFLAGS=-L/usr/lib64\
 && make -j 16\
 && make install\
 && cd ..\
 && rm -rf ./libiconv-1.14\
 && tar zxf ./png-1.2.18.tar.gz\
 && cd ./png/1.2.18\
 && ./configure --prefix=/usr/local/libpng LDFLAGS=-L/usr/lib64\
 && make -j 16\
 && make install\
 && cd ../../\
 && rm -rf ./png\
 && tar zxf ./libmcrypt-2.5.8.tar.gz\
 && cd libmcrypt-2.5.8\
 && ./configure --prefix=/usr/local/libmcrypt LDFLAGS=-L/usr/lib64\
 && make -j 16\
 && make install\
 && cd ../\
 && rm -rf libmcrypt-2.5.8\
 && tar zxf ./gd-2.0.35.tar.gz \
 && cd ./gd/2.0.35\
 && sed -i "s/png\.h/\/usr\/local\/libpng\/include\/png\.h/g" ./gd_png.c\
 && ./configure --prefix=/usr/local/gd2 --with-png=/usr/local/libpng --with-freetype=/usr/local/freetype2  --with-jpeg=/usr/local/jpeg-6 LDFLAGS=-L/usr/lib64\
 && make -j 16\
 && make install\
 && cd ../..\
 && rm -rf ./gd\
 && cd /root/lamp\
 && tar zxvf ./libevent-2.0.17-stable.tar.gz \
 && cd ./libevent-2.0.17-stable\
 && ./configure --prefix=/usr/local/libevent LDFLAGS=-L/usr/lib64\
 && make -j 16\
 && make install\
 && cd ..\
 && rm -rf ./libevent-2.0.17-stable\
 && tar zxvf ./curl-7.24.0.tar.gz\
 && cd ./curl-7.24.0\
 && ./configure --prefix=/usr/local/curl7 LDFLAGS=-L/usr/lib64\
 && make -j 16\
 && make install\
 && cd ..\
 && rm -rf ./curl-7.24.0
}
sendMail()
{
	LC_IP=`/sbin/ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"`\
 && echo "KO"|mail -s "$LC_IP install finished" easytzb@gmail.com
}
php()
{	
	cd /root/lamp\
 && tar zxvf ./libmcrypt-2.5.8.tar.gz\
 && cd ./libmcrypt-2.5.8\
 && ./configure -enable-ltdl-install\
 && mv ./libtool ./libtool.bak\
 && cp /usr/bin/libtool ./libtool\
 && make \
 && make install\
 && cd ..\
 && tar xf ./php-5.3.28.tar.bz2\
 && cd ./php-5.3.28\
 && (if test "$install_php" = "apache" ;	then 
	./configure --prefix=/webser/php53 --with-apxs2=/webser/httpd2/bin/apxs --with-config-file-path=/webser/php53/etc --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd  --enable-mbstring --enable-soap --enable-sockets --enable-zip --without-sqlite3 --without-pdo-sqlite --without-sqlite --without-pear --disable-short-tags --with-curl=/usr/local/curl7 --with-libxml-dir=/usr/local/libxml2 --with-zlib-dir=/usr/local/zlib --with-gd=/usr/local/gd2 --with-jpeg-dir=/usr/local/jpeg-6 --with-png-dir=/usr/local/libpng --with-freetype-dir=/usr/local/freetype2 --with-iconv-dir=/usr/local/libiconv --with-mcrypt=/usr/local/libmcrypt LDFLAGS=-L/usr/lib64 
	else 
	./configure --prefix=/webser/php53 --enable-fpm --with-config-file-path=/webser/php53/etc --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd  --enable-mbstring --enable-soap --enable-sockets --enable-zip --without-sqlite3 --without-pdo-sqlite --without-sqlite --without-pear --disable-ipv6 --disable-short-tags --with-curl=/usr/local/curl7 --with-libxml-dir=/usr/local/libxml2 --with-zlib-dir=/usr/local/zlib --with-gd=/usr/local/gd2 --with-jpeg-dir=/usr/local/jpeg-6 --with-png-dir=/usr/local/libpng --with-freetype-dir=/usr/local/freetype2 --with-iconv-dir=/usr/local/libiconv --with-mcrypt=/usr/local/libmcrypt LDFLAGS=-L/usr/lib64 
	fi)\
 && mv /root/lamp/php-5.3.28/libtool /root/lamp/php-5.3.28/libtool.bak\
 && cp /usr/bin/libtool /root/lamp/php-5.3.28/libtool\
 && make -j 16\
 && make install\
 && (groupadd -f www; useradd -u 1000 -g www www; echo '1')\
 && mkdir -p /webser/www\
 && cd ..\
 && rm -rf ./php-5.3.28\
 && cp -f /root/lamp/config/php.ini /webser/php53/etc/php.ini\
 && (if test "$install_php" = "nginx"; then 
	cp -f /root/lamp/config/php-fpm.conf /webser/php53/etc/php-fpm.conf\
 && cp -f /root/lamp/shell/startnginx /webser/startnginx\
 && cp -f /root/lamp/shell/stopnginx /webser/stopnginx\
 && chmod +x /webser/stopnginx\
 && chmod +x /webser/startnginx
	fi)\
 && mkdir -p /webser/sess_tmp\
 && chown -R www:www /webser/sess_tmp\
 && cd /root/lamp\
 && tar zxvf ./suhosin-0.9.32.1.tar.gz\
 && cd ./suhosin-0.9.32.1\
 && /webser/php53/bin/phpize\
 && ./configure --with-php-config=/webser/php53/bin/php-config\
 && make -j 16\
 && make install\
 && cd ..\
 && rm -rf ./suhosin-0.9.32.1\
 && tar xf ./memcache-2.2.6.tgz\
 && cd ./memcache-2.2.6\
 && /webser/php53/bin/phpize\
 && ./configure --with-php-config=/webser/php53/bin/php-config\
 && make -j 16\
 && make install\
 && cd ..\
 && rm -rf ./memcache-2.2.6\
 && tar xf ./eaccelerator-0.9.6.1.tar.bz2\
 && cd ./eaccelerator-0.9.6.1\
 && /webser/php53/bin/phpize\
 && ./configure --with-php-config=/webser/php53/bin/php-config --without-eaccelerator-use-inode\
 && make -j 16\
 && make install\
 && cd ..\
 && rm -rf ./eaccelerator-0.9.6.1\
 && mkdir -p /webser/eacc_cache\
 && chown -R www:www /webser/eacc_cache\
 && echo 1 > /proc/sys/net/ipv4/tcp_tw_reuse\
 && echo 1 > /proc/sys/net/ipv4/tcp_tw_recycle\
 && echo 1 > /proc/sys/net/ipv4/tcp_timestamps
if [ `cat /etc/sysctl.conf|grep tcp_max_syn_backlog|wc -l` == 0 ] ; then echo -ne "net.ipv4.tcp_max_syn_backlog = 4096\nnet.core.netdev_max_backlog = 4096\nnet.core.somaxconn = 4096" >> /etc/sysctl.conf;sysctl -p; fi
echo 1 > /proc/sys/net/ipv4/tcp_tw_reuse
echo 1 > /proc/sys/net/ipv4/tcp_tw_recycle
echo 1 > /proc/sys/net/ipv4/tcp_timestamps
}
ftp()
{
	rpm -ivh vsftpd-2.0.5-16.el5_5.1.x86_64.rpm
	groupadd ftpuser
	useradd -g ftpuser game_department -d /webser/www/stnts_tq/www/bbs -M ##/webser/www/stnts_tq/www/bbs
	passwd game_department
	#userdel game_department
	chsh -s /sbin/nologin game_department
	service vsftpd start
	setfacl -R -m u:game_department:rwx /webser/www/stnts_tq/www/bbs
}
getInput()
{
	export LANG="zh_CN.UTF-8"
        read -p " $info。 开始安装？(y/n):" input;
        if (test "$input" != "y")\
 && (test "$input" != "n") \
 && (test "$input" != "Y")\
 && (test "$input" != "N")
        then
		export LANG="zh_CN.UTF-8"
		echo '按错了吧，再来一次，"y" or "n":'
                getInput;
        fi
}
parse_arg()
{
  echo $1 | sed -e 's/^[^=]*=//'
}
usage()
{
  export LANG="zh_CN.UTF-8"
  cat <<EOF
Usage: $0 [OPTIONS] 
  --ftp			安装ftp。需要修改脚本ftp函数中的用户名等信息
  --mysql50		安装mysql50。
  --mysql51		安装mysql51，与mysql5.1的同时安装，需要修改启动脚本/webser/startmysql。
  --mysql55		安装mysql55，与mysql5.5的同时安装，需要修改启动脚本/webser/startmysql。
  -h --help		你懂的。
  --php[=nginx|apache]	安装php，默认为nginx。
  --varnish		安装varnish。
  --ifstat		安装ifstat。
  --rsync3		安装rsync3。
EOF
  exit 1
}
install_ftp=0;
install_mysql51=0;
install_mysql50=0;
install_mysql55=0;
install_php=0;
install_varnish=0;
install_ifstat=0;
install_rsync3=0;
info="你选择了"
for arg
  do
    case "$arg" in	
	--ftp) install_ftp=1\
 && info="$info FTP"  ;;
	--mysql50) install_mysql50=1\
 && info="$info MySQL5.0" ;;
	--mysql51) install_mysql51=1\
 && info="$info MySQL5.1" ;;
	--mysql55) install_mysql55=1\
 && info="$info MySQL5.5" ;;
	--varnish) install_varnish=1\
 && info="$info Varnish 3.0.2" ;;
	--ifstat) install_ifstat=1\
 && info="$info ifstat" ;;
 	--rsync3) install_rsync3=1\
 && info="$info rsync3" ;;
	--help) usage ;;
	-h) usage ;;
	--php*) tmp=`parse_arg "$arg"`; if test "$tmp" = "apache"; then install_php="apache"; info="$info PHP+APACHE"; 
	else install_php="nginx"; info="$info PHP+NGINX";fi;;
    esac
  done
export LANG="zh_CN.UTF-8"
if test "$info" = "你选择了"; then echo "Error：请指定要安装的软件"; usage; fi
input=0
getInput;
if test "$input" = "n" || test "$input" = "N"
then
	exit 1
fi
#begin to install
(if test "$install_mysql50" = "1"; 
then mysql50; fi)\
 && (if test "$install_mysql51" = "1" ; 
then mysql51; fi)\
 && (if test "$install_mysql55" = "1" ; 
then mysql55; fi)\
 && (if test "$install_php" != "0" ; 
then baselib; fi)\
 && (if test "$install_mysql51" = "1" ; 
then changeMysqlPwd; fi)\
 && (if test "$install_mysql55" = "1" ; 
then changeMysqlPwd; fi)\
 && (if test "$install_php" = "apache" ; 
then apache\
 && php; fi)\
 && (if test "$install_php" = "nginx" ; 
then php; nginx; fi)\
 && (if test "$install_ftp" != "0" ; 
then ftp; fi)\
 && (if test "$install_varnish" != "0" ; 
then varnish; fi)\
 && (if test "$install_ifstat" != "0" ; 
then ifstat; fi)\
 && (if test "$install_rsync3" != "0" ; 
then rsync3; fi)\
 && sendMail;