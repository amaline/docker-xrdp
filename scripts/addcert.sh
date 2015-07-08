#!/bin/sh
echo "Adding firewall cert"
pwd
cp sync/files/proxy.crt /etc/pki/ca-trust/source/anchors/
update-ca-trust extract
