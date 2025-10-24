#!/bin/bash
set -eu

ip route del default 2>/dev/null || true
ip route add default via "$GATEWAY_IP" || true

apk add shadow openssh sudo

chmod +x /usr/local/bin/ansible_agent_deploy.sh
/usr/local/bin/ansible_agent_deploy.sh
/usr/sbin/sshd

exec /usr/share/bunkerweb/entrypoint.sh "$@"
