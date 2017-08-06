FROM resin/raspberry-pi2-debian:latest

# shell to start from Kitematic
ENV DEBIAN_FRONTEND=noninteractive
ENV SHELL=/bin/bash

# install dependencies
RUN apt-get update && \
    apt-get install -y apt-utils && \
    apt-get upgrade -y && \
    apt-get install -y \
      rsyslog \
      wget \
      cron \
      nano \
      unzip \
      spamassassin \
      imapfilter \
      python \
      python-pip \
      razor \
      pyzor \
    && \
    pip install --upgrade pip && \
    pip install docopt==0.6.2

WORKDIR /root

# install isbg
RUN wget https://github.com/isbg/isbg/archive/master.zip && \
    mv master.zip isbg.zip && \
    unzip isbg.zip && \
    cd isbg-master && \
    python setup.py install && \
    cd .. && \
    rm -Rf isbg-master && \
    rm isbg.zip

# copy config files and scripts
ADD files/* /root/

# set up
RUN mkdir -p /var/spamassassin/bayesdb && \
    chown -R debian-spamd:mail /var/spamassassin && \
    sed -i 's/ENABLED=0/ENABLED=1/;s/CRON=0/CRON=1/;s/^OPTIONS=".*"/OPTIONS="--allow-tell --max-children 5 --helper-home-dir -u debian-spamd -x --virtual-config-dir=\/var\/spamassassin"/' /etc/default/spamassassin && \
    echo "bayes_path /var/spamassassin/bayesdb/bayes" >> /etc/spamassassin/local.cf && \
    crontab cron_scans && rm cron_scans && \
    mkdir .imapfilter && mkdir accounts && \
    mv bashrc .bashrc

# volumes
VOLUME /var/spamassassin
VOLUME /root/.imapfilter
VOLUME /root/accounts

CMD /root/startup && tail -n 0 -F /var/log/lastlog /var/log/syslog
