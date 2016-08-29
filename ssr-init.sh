#!/bin/sh
password=your_password_here
sudo apt-get install git tmux
git clone -b manyuser https://github.com/breakwa11/shadowsocks.git
sudo ln -s $(readlink -f ./shadowsocks/shadowsocks) /usr/local/shadowsocks
sed 's/"password".*/"password":"'$password'",/g' shadowsocks/config.json > myconfig.json
sudo mv myconfig.json /etc/shadowsocks.json
#https://github.com/breakwa11/shadowsocks-rss/wiki/System-startup-script
cat > shadowsocks.service <<EOF
[Unit]
Description=Start or stop the ShadowsocksR server
After=network.target
Wants=network.target
[Service]
Type=forking
PIDFile=/var/run/shadowsocks.pid
ExecStart=/usr/bin/python /usr/local/shadowsocks/server.py --pid-file /var/run/shadowsocks.pid -c /etc/shadowsocks.json -d start
ExecStop=/usr/bin/python /usr/local/shadowsocks/server.py --pid-file /var/run/shadowsocks.pid -c /etc/shadowsocks.json -d stop
[Install]
WantedBy=multi-user.target
EOF
sudo mv shadowsocks.service /etc/systemd/system/shadowsocks.service
sudo systemctl enable shadowsocks.service
systemctl start shadowsocks.service
