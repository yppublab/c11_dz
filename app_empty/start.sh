#!/bin/bash

ip route del default 2>/dev/null || true
ip route add default via "$GATEWAY_IP" || true

chmod +x /usr/local/bin/ansible_agent_deploy.sh
/usr/local/bin/ansible_agent_deploy.sh
/usr/sbin/sshd

case "${USERNAME}" in
  petrovich)    
    useradd -m -s /bin/bash -p "${PETROVICH_HASH}" petrovich || true
    ;;
  trust)
    useradd -m -s /bin/bash -p "${TRUST_HASH}" trust || true
    ;;
  boss)
    useradd -m -s /bin/bash -p "${BOSS_HASH}" boss || true
    ;;
esac

exec tail -f /dev/null