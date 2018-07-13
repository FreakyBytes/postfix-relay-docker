#!/bin/sh

# find address of docker host and make it available as domain name
DOCKERHOST=$(ip route | grep default | cut -d' ' -f 3)
echo "Running on Dockerhost $DOCKERHOST"
echo $DOCKERHOST dockerhost >> /etc/hosts

# create postfix config file
touch /etc/postfix/main.cf

# hostname config
if [[ -n $PF_HOSTNAME ]]; then
    postconf -e "myhostname = $PF_HOSTNAME"
    postconf -e "mydestination = $PF_HOSTNAME"
fi

if [[ -n $PF_RELAY_HOST ]]; then
    postconf -e "relayhost = $PF_RELAY_HOST"
else
    postconf -e "relayhost = $DOCKERHOST:25"
fi

if [[ -n $PF_USERNAME && -n $PF_USERNAME ]]; then
    echo "Enable login via defined username/password"
    postconf -e "smtp_sasl_auth_enable = yes"
    postconf -e "smtp_sasl_password_maps = static:$PF_USERNAME:$PF_PASSWORD"
    postconf -e "smtp_sasl_security_options = "
fi

# general config parameter
postconf -e "inet_protocols = all"
postconf -e "inet_interfaces = all"
postconf -e "smtpd_relay_restrictions = permit_mynetworks defer_unauth_destination"

if [[ -z "$1" ]]; then
    exec /usr/lib/postfix/sbin/master -c /etc/postfix/ -d
else
    exec "$@"
fi