ARG ARCH=
FROM bayrell/alpine_php_fpm:7.4-9${ARCH}

ADD download /src/download
RUN cd ~; \
	apk update; \
	apk upgrade; \
	apk add python3 python3-dev py3-pip gcc musl-dev linux-headers openssl-dev libffi-dev php7-pdo_pgsql; \
	pip3 install --upgrade pip; \
	pip3 install /src/download/pgadmin4-6.9-py3-none-any.whl; \
	pip3 install uwsgi; \
	rm -rf /src/download; \
	rm -rf /var/cache/apk/*; \
	echo 'Ok'
	
ADD files /src/files
RUN cd ~; \
	rm -rf /var/www/html; \
	cp -rf /src/files/etc/* /etc/; \
	cp -rf /src/files/root/* /root/; \
	cp -rf /src/files/var/www/html /var/www/; \
	cp /root/config_local.py /usr/lib/python3.9/site-packages/pgadmin4; \
	ln -s /data/pgadmin /var/lib/pgadmin; \
	rm -rf /src/files; \
	chmod +x /root/run.sh; \
	echo 'Ok'
