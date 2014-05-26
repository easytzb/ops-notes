###相关链接
[php扩展phpredis](https://github.com/nicolasff/phpredis)
[redis下载](http://redis.io/download)

###安装
安装解压出的文件mv放到要安装的目录 make 即可

	wget http://download.redis.io/releases/redis-2.8.5.tar.gz
	tar zxf /root/redis-2.8.5.tar.gz
	mv redis-2.8.5 /webser/redis;
	cd /webser/redis
	make -j 16

###运行
./src/redis-server [/path/to/redis.conf]

###持久化保存
* 除了save 配置外，在redis shutdown、从机的启动都会促发快照
* rdb方式更注重性能，在快照时，主进程只需要fork一个子进程，磁盘的IO的交给子进程即可。
* aof更注重数据的完整性，所以在appendonly yes后，启动都从aof文件中恢复数据，而不是rdb
* runtime修改appendonly yes后，开启aof前的老数据将自动rewrite到aof文件中


###优化
1. Add vm.overcommit_memory = 1 to /etc/sysctl.conf and then reboot or run the command sysctl vm.overcommit_memory=1 for this to take effect immediately.
2. setup some swap
3. 对于写密集的环境，应将内存设置为预计的2倍
4. 主从复制时，即使是关闭了快照，也会快照
5. If you are deploying using a virtual machine that uses the Xen hypervisor you may experience slow fork() times.
6. Use daemonize no when run under daemontools


###平滑修改配置及升级
[modify options runtime](http://redis.io/commands/config-set)
[upgrade](http://redis.io/topics/admin upgrade), 依然做不到平滑升级
* 安装新版本newredis,并配置为老版本实例的从服务器
* 同步完成后，关闭原redis，更改端口启用新版redis

###集群指令
* down-after-milliseconds 多长时间没响应算down
* can-failover 是否failover
* parallel-syncs failover后，一次重设置几个slave的master，