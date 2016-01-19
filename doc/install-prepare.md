#安装前准备
包括centos7依赖包安装、时钟同步设置等

##时钟同步
###安装NTP服务
```bash
[root@localhost ~]# yum install -y ntpdate
.......省略
Installed:
  ntpdate.x86_64 0:4.2.6p5-22.el7.centos                                                                                                                                                       

Complete!

```
###同步
把当前时区调整为上海就是+8区,想改其他时区也可以去看看/usr/share/zoneinfo目录;
```bash
[root@localhost ~]# cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
cp: overwrite ‘/etc/localtime’? y
```
利用ntpdate同步标准时间
```bash
[root@localhost ~]# ntpdate us.pool.ntp.org
15 Jan 14:00:33 ntpdate[20070]: step time server 128.113.28.67 offset -46738.695145 sec
```

加入定时计划任务，每隔10分钟同步一下时钟
```bash
[root@localhost ~]# crontab -e
添加一行
0-59/10 * * * * /usr/sbin/ntpdate us.pool.ntp.org | logger -t NTP
```


