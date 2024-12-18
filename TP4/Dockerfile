FROM python:3
RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
		build-essential \
		pkg-config \
		default-libmysqlclient-dev && \
	apt-get clean
RUN pip install --upgrade pip
RUN pip install flask-mysqldb 
RUN pip install mysql-connector-python
RUN mkdir -p /srv/templates
COPY index.html /srv/templates/
COPY app_1.py /srv/
CMD ["flask", "--app", "/srv/app_1", "run", "--host=0.0.0.0"]
