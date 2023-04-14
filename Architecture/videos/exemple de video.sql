==========================Lancer le HDFS =================================
start-dfs.sh
start-yarn.sh


==================================NOSQL KVSTORE============================================
nohup java -Xmx256m -Xms256m -jar $KVHOME/lib/kvstore.jar kvlite -secure-config disable -root $KVROOT > kvstore.log 2>&1 &
java -Xmx256m -Xms256m -jar $KVHOME/lib/sql.jar -helper-hosts localhost:5000 -store kvstore

CREATE table nosql_marketing2(
	AGE INTEGER, 
	SEXE ENUM(M,F,vide) DEFAULT vide,
	TAUX INTEGER,
	SITUATION_FAMILIALE ENUM (vide,Celibataire, Divorcee,En_Couple, Marie,Seul,Seule) DEFAULT vide,
	NB_ENFANTS_ACHARGE INTEGER,
	DEUXIEME_VOITURE BOOLEAN,
	PRIMARY KEY(AGE)
);

sql-> import -table nosql_marketing2 -file Marketing.csv CSV

select * from nosql_marketing2

=====================================MongoDB===================================================
sudo systemctl start mongod
mongo

db.createCollection("marketing")

mongoimport --db mongo_bigdata --collection marketing --type csv --file Marketing.csv --headerline


=======================================HDFS ===============================================

hdfs dfs -mkdir /marketing2
hdfs dfs -put Marketing.csv /marketing2/hdfs_marketing2.csv

=======================================Tables Externes=====================================================
CREATE EXTERNAL TABLE  nosql_H_MARKETING  (
AGE int, 
SEXE string, 
TAUX int,
SITUATION_FAMILIALE string,
NB_ENFANTS_ACHARGE int,
DEUXIEME_VOITURE boolean
)
STORED BY 'oracle.kv.hadoop.hive.table.TableStorageHandler'
TBLPROPERTIES (
"oracle.kv.kvstore" = "kvstore",
"oracle.kv.hosts" = "localhost:5000", 
"oracle.kv.hadoop.hosts" = "localhost/0.0.0.0", 
"oracle.kv.tableName" = "nosql_marketing");


CREATE EXTERNAL TABLE mongo_marketing ( 
id STRING,  
AGE INT, 
SEXE STRING,
TAUX STRING,
SITUATION_FAMILIALE STRING,
NB_ENFANTS_ACHARGE INT,
DEUXIEME_VOITURE BOOLEAN)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{"id":"_id"}')
TBLPROPERTIES('mongo.uri'='mongodb://localhost:27017/mongo_bigdata.marketing');


CREATE EXTERNAL TABLE hdfs_marketing (
  AGE INT,
  SEXE STRING,
  TAUX INT,
  SITUATION_FAMILIALE STRING,
  NB_ENFANTS_ACHARGE INT,
  DEUXIEME_VOITURE BOOLEAN
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'hdfs:/data/data_marketing';