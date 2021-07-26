** WORK IN PROGRESS

*** Generate random secret for drone

```
openssl rand -hex 16
```

*** Make certificates 

```
mkdir certificates 
cd certificates
mkcert -install 
mkcert -CAROOT
mkcert ops.dev *.ops.dev
``` 

*** Check services

curl --cacert  $(mkcert -CAROOT)/rootCA.pem https://whoami.ops.dev
git clone -c http.sslCAInfo=$(mkcert -CAROOT)/rootCA.pem https://gitea.ops.dev/edersohe/test.git

*** DONE

* traefik
* gitea
* drone

*** TODO

* sentry
* docker registry
* rocket.chat
* minio
* prometheus + graphana
