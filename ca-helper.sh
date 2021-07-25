#!/usr/bin/env bash

#Example taked from https://dev.to/techschoolguru/how-to-create-sign-ssl-tls-certificates-2aai

data_dir=traefik/certs

build_subj() {
  read -p "Country: " c
  read -p "State: " st
  read -p "Locality: " l
  read -p "Organization: " o
  read -p "Organization Unit: " ou
  local domain
  read -p "Domain:" domain
  read -p "Email: " email
  echo "/C=${c}/ST=${st}/L=${l}/O=${o}/OU=${ou}/CN=*.${domain}/emailAddress=${email}"
}

mkdir -p ${data_dir}
subj=$(build_subj)

echo "Generate CA's private key and self-signed certificate"
openssl req -x509 -newkey rsa:4096 -days 1095 -nodes -keyout ${data_dir}/ca-key.pem -out ${data_dir}/ca-cert.pem -subj "$(echo ${subj} | sed 's/CN=\*\./CN=ca./g')"

echo "CA's self-signed certificate"
openssl x509 -in ${data_dir}/ca-cert.pem -noout -text

echo "Generate web server's private key and certificate signing request (CSR)"
openssl req -newkey rsa:4096 -nodes -keyout ${data_dir}/server-key.pem -out ${data_dir}/server-req.pem -subj "${subj}" -addext "subjectAltName = DNS:*.${domain},IP:0.0.0.0" 

echo "Use CA's private key to sign web server's CSR and get back the signed certificate"
openssl x509 -req -in ${data_dir}/server-req.pem -days 1095 -CA ${data_dir}/ca-cert.pem -CAkey ${data_dir}/ca-key.pem -CAcreateserial -out ${data_dir}/server-cert.pem

echo "Server's signed certificate"
openssl x509 -in ${data_dir}/server-cert.pem -noout -text

echo "Verify if is valid certificate with the Root certifiate"
openssl verify -CAfile ${data_dir}/ca-cert.pem ${data_dir}/server-cert.pem

