Docker container that uses [isbg](https://github.com/dc55028/isbg) and [imapfilter](https://github.com/lefcha/imapfilter) to filter out spam from a remote IMAP server. (Raspberry Pi 2 version)

Docker Hub link: https://hub.docker.com/r/domcomte/imapscan-rpi2/

[![](https://images.microbadger.com/badges/image/domcomte/imapscan-rpi2.svg)] [![](https://images.microbadger.com/badges/version/domcomte/imapscan-rpi2.svg)]


Configuration:
There are 3 volumes, their content is initialized during container startup:
- /var/spamassassin : holds the SpamAssassin data files, to keep them between container resets.
- /root/.imapfilter : holds the ImapFilter configuration script.
- /root/accounts    : holds the IMAP accounts configuration.
