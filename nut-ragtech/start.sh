#!/bin/bash
set -e

OPTIONS=/data/options.json
PORT=$(jq -r '.port // "/dev/ttyACM0"' "$OPTIONS")
PASSWORD=$(jq -r '.password // "change_me"' "$OPTIONS")
VA=$(jq -r '.va // 0' "$OPTIONS")
ALLOW=$(jq -r '.allow_shutdown // false' "$OPTIONS")

mkdir -p /etc/nut /var/state/ups /run/nut

{
  echo "[ragtech]"
  echo "  driver = ragtech"
  echo "  port = ${PORT}"
  echo "  desc = \"Ragtech 1200VA\""
  if [ "${VA}" -gt 0 ] 2>/dev/null; then
    echo "  va = ${VA}"
  fi
  if [ "${ALLOW}" = "true" ]; then
    echo "  allow_shutdown"
  fi
} > /etc/nut/ups.conf

cat > /etc/nut/upsd.conf <<EOF
LISTEN 0.0.0.0 3493
EOF

cat > /etc/nut/upsd.users <<EOF
[upsmon]
  password = ${PASSWORD}
  upsmon master
EOF

chown -R root:root /etc/nut
chmod 640 /etc/nut/upsd.users

echo "Iniciando driver ragtech na porta ${PORT}..."
upsdrvctl start

echo "Iniciando upsd..."
exec upsd -F
