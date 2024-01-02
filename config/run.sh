
service postgresql restart 
service redis-server restart
#service nginx start


#/opt/netbox/venv/bin/python3 /opt/netbox/netbox/manage.py housekeeping
#opt/netbox/venv/bin/python3 /opt/netbox/netbox/manage.py rqworker high default low
#/opt/netbox/venv/bin/gunicorn --pid /var/tmp/netbox.pid --pythonpath /opt/netbox/netbox --config /opt/netbox/gunicorn.py netbox.wsgi