# SSHPortal

```
Host SP
    HostName sp.foo.bar
    User remote_uname
    IdentityFile %d/.ssh/id
    Port 10022

Host HOST??
    HostName %h.foo.bar

Match Host host??.foo.bar Exec "curl -s ifconfig.me | grep ^999 || exit 0"
# Match Host host??.foo.bar Exec "curl.exe -s ifconfig.me | findstr -r ^999 || exit 0"
    ProxyCommand ssh SP nc %h %p
```
