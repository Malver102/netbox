FROM ubuntu 


ENV DEBIAN_FRONTEND=noninteractive
ENV DJANGO_DB_NAME=default
ENV DJANGO_SU_NAME=admin
ENV DJANGO_SU_EMAIL=admin@my.company
ENV DJANGO_SU_PASSWORD=qwe123!@#


RUN apt update \
        && apt install -y git postgresql redis-server python3 python3-pip \
         python3-venv python3-dev build-essential libxml2-dev libxslt1-dev \
         libffi-dev libpq-dev libssl-dev zlib1g-dev nginx

RUN cd /opt \
    && git clone -b master https://github.com/netbox-community/netbox.git \
    && cd /opt/netbox \
    && cp /opt/netbox/contrib/nginx.conf /etc/nginx/sites-available/default 
    

COPY config/configuration.py /opt/netbox/netbox/netbox

RUN adduser --system --group netbox \
    && chown --recursive netbox /opt/netbox/netbox/media/ \
    && chown --recursive netbox /opt/netbox/netbox/reports/ \
    && chown --recursive netbox /opt/netbox/netbox/scripts/ \
    && chown -R postgres:postgres /etc/postgresql \
    && chown -R netbox:netbox /opt/netbox \
    && chmod 774 /opt/netbox

#COPY config/pg_hba.conf /etc/postgresql/14/main/pg_hba.conf
#COPY config/postgresql.conf /etc/postgresql/14/main/


COPY config/psql.sh /
RUN chmod +x /psql.sh 
#RUN /bin/bash -c "/psql.sh" 

RUN service redis-server start

ENV PATH="/opt/netbox/venv/bin:$PATH"

RUN pip config set global.trusted-host "pypi.org files.pythonhosted.org pypi.python.org"


RUN service postgresql start
#RUN /opt/netbox/upgrade.sh



#RUN python3 -c "import django; django.setup(); \
#   from django.contrib.auth.management.commands.createsuperuser import get_user_model; \
#   get_user_model()._default_manager.db_manager('$DJANGO_DB_NAME').create_superuser( \
#   username='$DJANGO_SU_NAME', \
#   email='$DJANGO_SU_EMAIL', \
#   password='$DJANGO_SU_PASSWORD')"

COPY config/run.sh /

RUN chmod +x /run.sh

EXPOSE 8001
#ENTRYPOINT [ "/bin/bash" ]
#CMD [ "/run.sh" ]

CMD [ "/bin/bash" ]
