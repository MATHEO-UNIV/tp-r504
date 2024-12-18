docker run  --rm -d \
   -p 3307:3306 \
   -v vol-sql-demo:/var/lib/mysql \
   --network net-tp4 \
   --name tp4-sql \
   --env MYSQL_ROOT_PASSWORD=foo \
   mysql:8.0
