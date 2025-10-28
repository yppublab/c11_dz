#!/bin/sh
set -eu

echo "[start.sh] Starting..."

GATEWAY_IP="${GATEWAY_IP}"

# Network route first (before apk fetches)
ip route del default 2>/dev/null || true
ip route add default via "$GATEWAY_IP" || true

# Packages
apk add bash nginx openssh iproute2 sudo openssl shadow nano

useradd -m -s /bin/bash -p "${PETROVICH_HASH}" petrovich || true

# Minimal nginx site
rm -f /etc/nginx/http.d/default.conf 2>/dev/null || true

# Разворачиваем sshd + ansible пользователя
chmod +x /usr/local/bin/ansible_agent_deploy.sh
/usr/local/bin/ansible_agent_deploy.sh
/usr/sbin/sshd

# Start services
nginx -g 'daemon off;'&
#nginx -s reload

exec tail -f /dev/null
