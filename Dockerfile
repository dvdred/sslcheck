# DOCKER FILE SSL CHECKS DATE

FROM centos:centos7
MAINTAINER David Rossi <david.rossi@cnr.it>

RUN yum clean all && yum install -y epel-release
RUN yum install -y ssmtp openssl openssl-libs mailx wget && yum upgrade -y && yum clean all

ADD ./conf/ssmtp.conf /etc/ssmtp/ssmtp.conf
ADD ./conf/revaliases /etc/ssmtp/revaliases
ADD ./conf/ssl-cert-info.sh /bin/ssl-cert-info
ADD ./conf/check-cert.sh /bin/check-cert
ADD ./ssl-sites-to-check.txt /ssl-sites-to-check.txt
