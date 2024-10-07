#!/bin/bash

#a
docker network create tplb

#b
docker build -t im-nginx-lb .

#c
mkdir -p shared1 shared2

#d
echo "<h1>Hello 1</h1>" > shared1/index.html
echo "<h1>Hello 2</h1>" > shared2/index.html

#e
docker run --rm -d \
	--name nginx1 \
	--network tplb \
	 -p 81:80 \
	-v $(pwd)/shared1:/usr/share/nginx/html \
	nginx

docker run --rm --name nginx2 --network tplb -d -p 82:80 -v $(pwd)/shared2:/usr/share/nginx/html nginx

#f
docker run --rm --name nginx-lb --network tplb -d -p 83:80 im-nginx-lb
