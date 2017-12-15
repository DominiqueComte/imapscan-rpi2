#! /bin/sh

docker service create --name imapscan \
 --mount type=bind,src=/opt/imapscan/accounts,dst=/root/accounts \
 --mount type=bind,src=/opt/imapscan/imapfilter,dst=/root/.imapfilter \
 --mount type=bind,src=/opt/imapscan/spamassassin,dst=/var/spamassassin \
 domcomte/imapscan-rpi2:0.15
