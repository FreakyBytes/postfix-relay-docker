Postfix Relay
=============

This is a Docker Image containing the Postfix MTA, preconfigured so it is easy
to use as mail relay for docker other container.

## Use the Image

The behaviour of the mail relay can be controlling using a few environment variables:

 * `PF_HOSTNAME`: The hostname of the mail relay. Used for the HELO command
 * `PF_RELAY_HOST`: Another mail server, to which the mails should be relayed
 * `PF_USERNAME`: SMTP Username for the relay
 * `PF_PASSWORD`: SMTP Password for the relay
 * `PF_ALLOWED_NETWORK`: Space separated list of allowed networks (cf. mynetworks)

 If `PF_USERNAME` and `PF_PASSWORD` are not provided application do not need to authenticate to the the Relay Server.

## Build the Image

Simply run

```
docker build -t freakybytes/postfix-relay .
```