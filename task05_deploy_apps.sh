#!/bin/bash
mkdir -p /tmp/configs
deploy_application() {
  local server="$1"
  echo "Deploying app to $server (simulated)"
  echo "deployed" > /tmp/configs/${server}.deployed
}
for i in 1 2 3; do
  deploy_application "web-0${i}.example.com"
done
echo "Deployment (simulated) complete."
