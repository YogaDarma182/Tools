#!/bin/bash
wget https://github.com/prometheus/node_exporter/releases/download/v1.2.2/node_exporter-1.2.2.linux-amd64.tar.gz
tar -xf node_exporter-1.2.2.linux-amd64.tar.gz
rm -r node_exporter-1.2.2.linux-amd64*
sudo useradd -rs /bin/false node_exporter
touch /etc/systemd/system/node_exporter.service
printf "
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
" >> /etc/systemd/system/node_exporter.service

cat /etc/systemd/system/node_exporter.service

sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter
sudo systemctl status node_exporter

sudo ufw allow from 10.0.0.46 to any port 9100
sudo ufw status numbered