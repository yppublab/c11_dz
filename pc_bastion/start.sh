#!/bin/bash

ip route del default || true
ip route add default via "$GATEWAY_IP" || true

useradd -m -s /bin/bash -p "${PETROVICH_HASH}" petrovich || true

chmod +x /usr/local/bin/ansible_agent_deploy.sh
/usr/local/bin/ansible_agent_deploy.sh
sudo sed -i 's/^#\?Port .*/Port 1832/' /etc/ssh/sshd_config
/usr/sbin/sshd -E /var/log/sshd.log

exec tail -f /dev/null