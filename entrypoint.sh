#!/usr/bin/env sh

set -o nounset

# Environment variables
[[ -z ${USER+x} ]] && USER="samba"
[[ -z ${PASS+x} ]] && PASS=$USER

# Set up user
addgroup -g 1000 samba
adduser -D -H -G samba -s /bin/false -u 1000 $USER
echo -e "$PASS\n$PASS" | smbpasswd -a -s $USER
chown $USER:samba /storage

# Samba config
cat << EOF | tee /config/smb.conf
[global]
    server string = Samba %v in docker
    workgroup = WORKGROUP
    netbios name = samba
    security = user

[storage]
    comment = Storage
    path = /storage
    read only = yes
    write list = $USER
EOF

# Start samba service
exec ionice -c 3 smbd \
    --foreground \
    --no-process-group \
    --configfile /config/smb.conf </dev/null