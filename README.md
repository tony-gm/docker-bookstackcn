# bookstackcn-docker

BookStack，基于MinDoc，使用Beego开发的在线文档管理系统，功能类似Gitbook和看云。 http://www.bookstack.cn

https://github.com/TruthHun/BookStack

## docker部署bookstack

1. 运行mysql容器

使用官方最新版本mysql镜像，根据实际情况修改数据库root密码，数据库名及登录用户名密码

官方镜像地址：https://hub.docker.com/_/mysql

```
docker run -itd --name mysql \
  --restart always \
  -p 3306:3306 \
  -e MYSQL_ROOT_PASSWORD=bookstack \
  -e MYSQL_DATABASE=bookstack \
  -e MYSQL_USER=bookstack \
  -e MYSQL_PASSWORD=bookstack \
  -v /data/mysql:/var/lib/mysql \
  mysql --default-authentication-plugin=mysql_native_password
```

2. 修改bookstack配置文件
   从https://github.com/TruthHun/BookStack上下载Release版本，复制conf至/data/bookstack/conf并更改对应配置

3. bookstack启动时会连接mysql，依赖mysql来存储数据。
```
docker run -itd --name bookstack \
  --restart always \
  -p 8181:8181 \
  -v /data/bookstack/conf:/opt/bookstack/conf \
  toplinker/bookstack
```

默认管理员账号和密码为 admin/admin888

http://192.168.1.1:8181
