
# Docker image with CentOS 7.9 Python 3.6.6 & Supervisor
Docker image with Python 3.6.6 and supervisor.

## DockerHub
https://hub.docker.com/repository/docker/vinodpandey/centos-p36/general

## usage
pull image
```
docker pull vinodpandey/centos-p36:1.0
```

cd to django code directory 
```
docker run -t -d -p 8000:8000 --name centos -v "$(pwd)":/opt/ vinodpandey/centos-p36:1.0
```

install dependencies
```
docker exec -it -w /opt centos pip3.6 install -r requirements.txt 
```

## django management commands
```

docker exec -it -w /opt centos python3.6 manage.py runserver 0.0.0.0:8000
docker exec -it -w /opt centos gunicorn project.dev_wsgi:application --bind=0.0.0.0:8000
docker exec -it -w /opt centos celery -A project._celery worker -l info -Q celery

```

## running supervisord
```
docker cp files/web.conf centos:/etc/supervisor/conf.d/
docker exec -it centos supervisord -c /etc/supervisord.conf
docker exec -it centos supervisorctl status
``` 


 



