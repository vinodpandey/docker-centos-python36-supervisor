FROM centos:7.9.2009

MAINTAINER Vinod Pandey

RUN yum -y install epel-release
RUN yum -y install wget make gcc openssl-devel bzip2-devel mysql-devel git vim python-pip
RUN yum clean all

# python 3.6.6
WORKDIR /tmp/
RUN wget -O Python-3.6.6.tgz https://www.python.org/ftp/python/3.6.6/Python-3.6.6.tgz
RUN tar xzf Python-3.6.6.tgz
WORKDIR /tmp/Python-3.6.6
RUN ./configure --enable-optimizations
RUN make altinstall
RUN ln -sfn /usr/local/bin/python3.6 /usr/bin/python3.6
RUN ln -sfn /usr/local/bin/pip3.6 /usr/bin/pip3.6

# upgrading pip
WORKDIR /opt/
RUN pip3.6 install pip==19.2.3

# supervisord
RUN mkdir -p /var/log/gunicorn/
RUN mkdir -p /var/log/supervisor/
RUN mkdir -p /etc/supervisor/conf.d/
RUN pip2.7 install supervisor==4.2.2
COPY files/supervisord.conf /etc/supervisord.conf

EXPOSE 8000
CMD ["/usr/sbin/init"]


