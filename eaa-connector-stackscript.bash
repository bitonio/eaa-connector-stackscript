#!/bin/bash -e
# Mandatory
#<UDF name="LABEL" label="Name of the connector as it appears in Enterprise Center">
#<UDF name="OPENAPI_HOST" label="{OPEN} API Host">
#<UDF name="OPENAPI_CLIENT_SECRET" label="Client Secret">
#<UDF name="OPENAPI_CLIENT_TOKEN" label="Client Token">
#<UDF name="OPENAPI_ACCESS_TOKEN" label="Access Token">

# Optional
#<UDF name="OPENAPI_ACCOUNT_KEY" label="Account Key" default="">

source <ssinclude StackScriptID="1">
exec > >(tee -i /var/log/stackscript.log)

export DEBIAN_FRONTEND=noninteractive
system_update

# Create the .edgerc file from the variable
echo '[default]' > /root/.edgerc
echo "host=${OPENAPI_HOST}" >> /root/.edgerc
echo "client_secret=${OPENAPI_CLIENT_SECRET}" >> /root/.edgerc
echo "client_token=${OPENAPI_CLIENT_TOKEN}" >> /root/.edgerc
echo "access_token=${OPENAPI_ACCESS_TOKEN}" >> /root/.edgerc
echo "account_key=${OPENAPI_ACCOUNT_KEY}" >> /root/.edgerc # Future proofing
echo "extra_qs=accountSwitchKey=${OPENAPI_ACCOUNT_KEY}" >> /root/.edgerc

apt -y install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt -y update
apt-cache policy docker-ce
apt -y install docker-ce

# https://github.com/akamai/eaa-k8s-connector#docker-deployment
docker run --rm --privileged \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume /root/.edgerc:/opt/akamai/.edgerc \
  --env CONNECTOR_NAME=${LABEL} \
  --name ${LABEL}-ekc \
  akamai/eaa-k8s-connector:latest

# end of script
