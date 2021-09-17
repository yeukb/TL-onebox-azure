locals {

  # Common tags to be assigned to all resources
  common_tags = {
    application = "Prisma Cloud Compute OneBox"
  }


    user_data = <<EOF
#!/bin/bash
sudo apt-get update && \
sudo apt-get upgrade -y && \
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common jq && \
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
sudo apt-get update && \
sudo apt-get install -y docker-ce docker-ce-cli containerd.io && \
sudo usermod -aG docker ${var.adminUsername} && \
mkdir twistlock && \
url=${var.twistlock_download_url} && \
filename=$${url##*/} && \
wget $url && \
tar -xzf $filename -C twistlock/ && \
cd twistlock/ && \
sudo ./twistlock.sh -s onebox && \
cd ~
# Wait for Console to come up
while true
do
  STATUS=$(curl -s -k -o /dev/null -w "%%{http_code}\n" -X GET https://localhost:8083/api/v1/_ping)
  if [ $STATUS -eq 200 ]; then
    echo "Got 200! Twistlock Console is UP"
    break
  else
    echo "Got $STATUS! Twistlock Console is NOT UP YET"
  fi
  sleep 2
done
# Create initial admin user
echo "Creating initial admin user ..."
curl -s -k -H 'Content-Type: application/json' -d '{"username": "${var.adminUsername}", "password": "${var.adminPassword}"}' https://localhost:8083/api/v1/signup
sleep 5
echo "Applying license key ..."
TOKEN=`curl -s -k -H "Content-Type: application/json" -d '{"username":"${var.adminUsername}", "password":"${var.adminPassword}"}' https://localhost:8083/api/v1/authenticate | jq -r .token`
curl -s -k -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d '{"key": "${var.license_key}"}' https://localhost:8083/api/v1/settings/license
EOF

}
