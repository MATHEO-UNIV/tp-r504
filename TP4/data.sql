CREATE DATABASE demosql2;
USE demosql2;
CREATE TABLE myTable(id int AUTO_INCREMENT,name varchar(45) NOT NULL, PRIMARY KEY (id) );
INSERT INTO myTable (id, name) VALUES (NULL, 'bob');
INSERT INTO myTable (id, name) VALUES (NULL, 'alice');
INSERT INTO myTable (id, name) VALUES (NULL, 'john');
