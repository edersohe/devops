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
mkcert ops.dev *.ops.dev localhost 127.0.0.1 0.0.0.0
``` 

*** Check services

curl --cacert  $(mkcert -CAROOT)/rootCA.pem https://whoami.ops.dev
git clone -c http.sslCAInfo=$(mkcert -CAROOT)/rootCA.pem https://gitea.ops.dev/edersohe/test.git


*** Add Gitea OAUTH2 Provider to RocketChat (Administration > Oauth > Add custom oauth)

```
Name: Gitea
URL: https://gitea.ops.dev
Token Path: /login/oauth/access_token
Token Sent Via: Payload
Identity Token Sent Via: Same as "Token Sent Via"
Identity Path: /api/v1/user
Authorized Path: /login/oauth/authorize
Scope: openid
Param Name for access token: access_token
Id: {ID_FROM_GITEA_OAUTH}
Secret: {SECRET_FROM_GITEA_OAUTH}
Login Style: Redirect
Button Text: Gitea Login
Key Field: email
Username field: login
Email field: email
Name Field: full_name
Avatar Field: avatar_url
Map Roles/Groups to channels: false
Merge Roles from SSO: true
Merge users: true
Show Button on Login Page: true
```


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
