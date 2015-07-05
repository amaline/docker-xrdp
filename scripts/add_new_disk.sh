set -e
set -x

if [ -f /etc/disk_added_date ]
then
  echo "disk already added so exiting."
  exit 0
fi

systemctl stop docker

cat > /etc/sysconfig/docker-storage-setup <<EOF
DEVS="/dev/sdb"
VG="docker-volg"
EOF

docker-storage-setup

systemctl restart docker

date > /etc/disk_added_date
