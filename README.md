# syslog-ng in docker


Exposed inputs:

* tcp port 514
* udp port 514
* unix socket `/var/run/syslog-ng/syslog-ng.sock`

## Usage

Listen for udp port 514 on `localhost` and save logs to `/var/log/syslog-ng`:

```
docker run -d -p 514:514/udp -v /var/log/syslog-ng:/var/log/syslog-ng --name syslog-ng v7hinc/docker-syslog-ng
```

If you want to export unix socket, just bind-mount `/var/run/syslog-ng` to host somewhere.

If you want to change config, just bind-mount it to `/etc/syslog-ng/syslog-ng.conf`.
