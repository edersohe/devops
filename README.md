
curl --cacert traefik/certs/ca-cert.pem https://whoami.edersohe.dev
git clone -c http.sslCAInfo=traefik/certs/ca-cert.pem https://gitea.edersohe.dev/edersohe/test.git
