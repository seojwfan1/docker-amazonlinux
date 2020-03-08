FROM scratch
ADD amzn-container-minimal-2018.03.0.20191014.0-x86_64.tar.xz /
CMD ["/bin/bash"]

RUN yum update -y && yum upgrade
RUN yum install -y httpd24 php70 mysql56-server php70-mysqlnd
RUN yum install -y php70-bcmath php70-gd php70-mbstring php70-mcrypt php70-zip
RUN yum install -y vim
#RUN yum install -y openssh-server
#RUN mkdir /var/run/sshd
#
##set password
#RUN echo 'root:root' |chpasswd
#
##replace sshd_config
#RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
#RUN sed -i 's/PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config
#RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
#
##make .ssh
#RUN mkdir /root/.ssh

RUN ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
RUN mkdir -p /var/www/home

COPY config/httpd.conf /etc/httpd/conf/httpd.conf
COPY config/php.conf /etc/httpd/conf.d/php.conf
COPY config/vhost.conf /etc/httpd/conf.d/vhost.conf
COPY config/php.ini /etc/php.ini

COPY run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run

EXPOSE 80 443

CMD ["/usr/local/bin/run" ]

