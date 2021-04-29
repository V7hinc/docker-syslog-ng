FROM alpine:3.13

ENV SYSLOG_VERSION=3.31.2
# syslog-ng源码包下载链接
ENV DOWNLOAD_URL="https://github.com/balabit/syslog-ng/releases/download/syslog-ng-${SYSLOG_VERSION}/syslog-ng-${SYSLOG_VERSION}.tar.gz"

RUN set -x;\
# 更新
apk update;\
# 安装必要组件
apk add glib pcre eventlog openssl openssl-dev;\
apk add curl alpine-sdk glib-dev pcre-dev eventlog-dev

WORKDIR /tmp
RUN set -x;\
curl -L "${DOWNLOAD_URL}" -o "syslog-ng-${SYSLOG_VERSION}.tar.gz";\
tar zxf "syslog-ng-${SYSLOG_VERSION}.tar.gz";\
cd "syslog-ng-${SYSLOG_VERSION}";\
# 编译安装
./configure --prefix=/usr;\
make;\
make install;\
cd ..;\
# 删除
rm -rf "syslog-ng-${SYSLOG_VERSION}" "syslog-ng-${SYSLOG_VERSION}.tar.gz";\
apk del curl alpine-sdk glib-dev pcre-dev eventlog-dev


#ADD ./syslog-ng.conf /etc/syslog-ng/syslog-ng.conf
WORKDIR /var/log/syslog-ng

VOLUME ["/var/log/syslog-ng", "/var/run/syslog-ng"]

EXPOSE 514/tcp 514/udp

CMD ["/usr/sbin/syslog-ng", "-F", "-f", "/etc/syslog-ng/syslog-ng.conf"]
