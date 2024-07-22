# Use CentOS 7 base image
FROM centos:centos7.9.2009

# Set environment variables
ENV DEFAULT_PHP=56
ENV DOCUMENT_ROOT=/

# Set DNS servers (optional)
#RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Install necessary packages for OpenLiteSpeed
RUN sed -i 's/centos.mirrors.ovh.net\/ftp.centos.org/vault.centos.org/g' /etc/yum.repos.d/CentOS-Base.repo && \
	sed -i 's/mirror.centos.org/vault.centos.org/g' /etc/yum.repos.d/CentOS-Base.repo && \
	sed -i -E 's/(baseurl.*)\$releasever/\17.9.2009/g' /etc/yum.repos.d/CentOS-Base.repo && \
	sed -i 's/^mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-Base.repo && \
	sed -i 's/#baseurl/baseurl/g' /etc/yum.repos.d/CentOS-Base.repo && \
    rpm -Uvh http://rpms.litespeedtech.com/centos/litespeed-repo-1.1-1.el7.noarch.rpm && \
	yum clean all && \
	yum -y update && \
    yum -y install epel-release && \
    yum -y install openlitespeed wget expect which && \
    yum -y install lsphp56* --skip-broken --exclude=lsphp56-ioncube-loader --exclude=lsphp56-mysql --exclude="*debug*" --exclude="*dbg*" --exclude="*devel*" && \
	yum -y install lsphp70* --skip-broken --exclude=lsphp70-mysql --exclude="*debug*" --exclude="*dbg*" --exclude="*devel*" && \
	yum -y install lsphp71* --skip-broken --exclude=lsphp71-mysql --exclude="*debug*" --exclude="*dbg*" --exclude="*devel*" && \
	yum -y install lsphp72* --skip-broken --exclude=lsphp72-mysql --exclude="*debug*" --exclude="*dbg*" --exclude="*devel*" && \
	yum -y install lsphp73* --skip-broken --exclude=lsphp73-mysql --exclude="*debug*" --exclude="*dbg*" --exclude="*devel*" && \
	rpm -e --nodeps  lsphp74-xml && \
	rpm -e --nodeps  lsphp74-process && \
	rpm -e --nodeps  lsphp74-pdo && \
	rpm -e --nodeps  lsphp74-opcache && \
	rpm -e --nodeps  lsphp74-mysqlnd && \
	rpm -e --nodeps  lsphp74-mbstring && \
	rpm -e --nodeps  lsphp74-imap && \
	rpm -e --nodeps  lsphp74-gd && \
	rpm -e --nodeps  lsphp74-common && \
	rpm -e --nodeps  lsphp74 && \
    /usr/local/lsws/admin/misc/lsup.sh -v 1.8.1 && \
    yum clean all && \
    rm -rf /tmp/* /usr/local/lsws/autoupdate/*.tgz /usr/local/lsws/autoupdate/openlitespeed && \
	mkdir /run/systemd/system && \
	mkdir /var/lib/php/session && \
	chown root:nobody /var/lib/php/session && \
	chmod 770 /var/lib/php/session && \
	mkdir -p /usr/local/lsws/Example/lscache && \
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /usr/local/lsws/Example.key -out /usr/local/lsws/Example.crt -subj "/C=US/ST=State/L=City/O=Organization/CN=Example"

# Expose ports
EXPOSE 80 443 7080

COPY httpd_config.conf /usr/local/lsws/conf/httpd_config.conf
COPY run_admpass.sh /usr/local/lsws/admin/misc/
COPY vhconf.conf /usr/local/lsws/conf/vhosts/Example/vhconf.conf
COPY php56.ini /usr/local/lsws/lsphp56/etc/php.ini
COPY php70.ini /usr/local/lsws/lsphp70/etc/php.ini
COPY php71.ini /usr/local/lsws/lsphp71/etc/php.ini
COPY php72.ini /usr/local/lsws/lsphp72/etc/php.ini
COPY php73.ini /usr/local/lsws/lsphp73/etc/php.ini

# Copy your entrypoint script into the image
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN chmod +x /usr/local/lsws/admin/misc/run_admpass.sh

# Run the script to set admin password
RUN /usr/local/lsws/admin/misc/run_admpass.sh

# Start OpenLiteSpeed
ENTRYPOINT ["/entrypoint.sh"]
CMD ["openlitespeed"]
