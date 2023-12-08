FROM ubuntu 

RUN apt update \
        && install -y git postgresql redis-server python3 python3-pip \
         python3-venv python3-dev build-essential libxml2-dev libxslt1-dev \
         libffi-dev libpq-dev libssl-dev zlib1g-dev


RUN mkdir -p /opt/netbox \
    && cd /opt/netbox

RUN git clone -b master https://github.com/netbox-community/netbox.git .

RUN adduser --system --group netbox \
    && chown --recursive netbox /opt/netbox/netbox/media/ \
    && chown --recursive netbox /opt/netbox/netbox/reports/ \
    && chown --recursive netbox /opt/netbox/netbox/scripts/

COPY config/configueation.py cd /opt/netbox/netbox/netbox/

RUN cp /opt/netbox/contrib/gunicorn.py /opt/netbox/gunicorn.py

RUN python3 /opt/netbox/upgrade.sh