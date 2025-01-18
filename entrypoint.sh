#!/usr/bin/env sh

set -o nounset

# Environment variables
[[ -z ${USER+x} ]] && USER="samba" && ANONYMOUS=true
[[ -z ${PASS+x} ]] && PASS=$USER

[[ "${UID:-""}" =~ ^[0-9]+$ ]] || UID=1000
[[ "${GID:-""}" =~ ^[0-9]+$ ]] || GID=1000

# Set up user
addgroup -g $GID samba
adduser -D -H -G samba -s /bin/false -u $UID $USER
echo -e "$PASS\n$PASS" | smbpasswd -a -s $USER
chown $USER:samba /storage

# Samba config
cat << EOF >> /config/smb.conf
[global]
    server string = Samba %v in docker
    workgroup = WORKGROUP
    disable netbios = yes
    smb ports = 445
    security = user

    dos charset = cp850
    unix charset = utf-8
    
[storage]
    comment = Storage
    path = /storage
EOF

# Private or public share
if [ -z ${ANONYMOUS+x} ]; then
    cat << EOF >> /config/smb.conf
    read only = yes
    write list = $USER
EOF
else
    cat << EOF >> /config/smb.conf
    guest ok = yes
    read only = no
    create mask = 0644
    force user = $USER
EOF
fi

# Start samba service
exec ionice -c 3 smbd \
    --foreground \
    --no-process-group \
    --configfile /config/smb.conf </dev/null