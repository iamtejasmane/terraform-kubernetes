FROM mariadb:10.5.2

MAINTAINER tejas

ENV MYSQL_DATABASE=simple-website \
    MYSQL_ROOT_PASSWORD=1234

ADD db.sql /docker-entrypoint-initdb.d

EXPOSE 3306