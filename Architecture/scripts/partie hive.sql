=======================================HIVE==============================================================

### lancer HIVE
nohup hive --service metastore > hive_metastore.log 2>&1 &
nohup hiveserver2 > hive_server.log 2>&1 &

### Connexion a HIVE
beeline -u jdbc:hive2://localhost:10000 vagrant
-----------------------------Table externe pointat vers nosql table (kvstore) in hive:--------------

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

CREATE EXTERNAL TABLE  nosql_H_IMMATRICULATION  ( 
	IMMATRICULATION string,
	MARQUE string,
	NOM string,
	PUISSANCE int,
	LONGEUR string,
	NBPLACES int,
	NBPORTES int,
	COULEUR string,
	OCCASION boolean,
	PRIX int
)
STORED BY 'oracle.kv.hadoop.hive.table.TableStorageHandler'
TBLPROPERTIES (
"oracle.kv.kvstore" = "kvstore",
"oracle.kv.hosts" = "localhost:5000", 
"oracle.kv.hadoop.hosts" = "localhost/0.0.0.0", 
"oracle.kv.tableName" = "nosql_immatriculation");

CREATE EXTERNAL TABLE  nosql_H_CLIENT ( 
	AGE int,
	SEXE string,
	TAUX int,
	SITUATION_FAMILIALE string,
	NB_ENFANTS_ACHARGE int,
	DEUXIEME_VOITURE boolean,
	IMMATRICULATION string
)
STORED BY 'oracle.kv.hadoop.hive.table.TableStorageHandler'
TBLPROPERTIES (
"oracle.kv.kvstore" = "kvstore",
"oracle.kv.hosts" = "localhost:5000", 
"oracle.kv.hadoop.hosts" = "localhost/0.0.0.0", 
"oracle.kv.tableName" = "nosql_client11");


CREATE EXTERNAL TABLE  nosql_H_CATALOGUE  (
	MARQUE string, 
	NOM string,
	PUISSANCE int,
	LONGEUR string,
	NBPLACES int,
	NBPORTES int,
	COULEUR string,
	OCCASION boolean,
	PRIX int
)
STORED BY 'oracle.kv.hadoop.hive.table.TableStorageHandler'
TBLPROPERTIES (
"oracle.kv.kvstore" = "kvstore",
"oracle.kv.hosts" = "localhost:5000", 
"oracle.kv.hadoop.hosts" = "localhost/0.0.0.0", 
"oracle.kv.tableName" = "nosql_catalogue");
==============================================================================================================
--------------------------Table externe hive pointant vers hdfs file:-----------------------------------------

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
LOCATION 'hdfs:/data/data_marketing';  {this is a location not a file : so we need to have just the file conserned in the repository}


CREATE EXTERNAL TABLE hdfs_client (
  AGE INT,
  SEXE STRING,
  TAUX INT,
  SITUATION_FAMILIALE STRING,
  NB_ENFANTS_ACHARGE INT,
  DEUXIEME_VOITURE BOOLEAN,
  immatriculation string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'hdfs:/data/data_client';


CREATE EXTERNAL TABLE hdfs_immatriculation (
	immatriculation STRING,
	marque STRING,
	nom STRING,
	puissance INT,
	longueur string,
	nbPlaces int,
	nbPortes int,
	couleur string,
	occasion string,
	prix int
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'hdfs:/data/data_immatriculation';


CREATE EXTERNAL TABLE hdfs_catalogue (
	MARQUE STRING,
	NOM STRING,
	PUISSANCE INT,
	longueur STRING,
	nbPlaces string,
	nbPortes string,
	COULEUR string,
	OCCASION string,
	PRIX int
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'hdfs:/data/data_catalogue';

==============================================================================================================
---------------------------------Tables externe hive pointant vers mongodb collection-------------------------

CREATE EXTERNAL TABLE mongo_marketing ( 
	id STRING,  
	AGE INT, 
	SEXE STRING,
	TAUX STRING,
	SITUATION_FAMILIALE STRING,
	NB_ENFANTS_ACHARGE INT,
	DEUXIEME_VOITURE string    
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{"id":"_id"}')
TBLPROPERTIES('mongo.uri'='mongodb://localhost:27017/mongo_bigdata.marketing');

CREATE EXTERNAL TABLE mongo_catalogue ( 
	id STRING,   
	MARQUE STRING,
	NOM STRING,
	PUISSANCE INT,
	longueur STRING,
	nbPlaces string,
	nbPortes string,
	COULEUR string,
	OCCASION string,
	PRIX int
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{"id":"_id"}')
TBLPROPERTIES('mongo.uri'='mongodb://localhost:27017/mongo_bigdata.catalogue');


CREATE EXTERNAL TABLE mongo_immatriculation ( 
	id STRING,   
	immatriculation STRING,
	marque STRING,
	nom STRING,
	puissance INT,
	longueur string,
	nbPlaces int,
	nbPortes int,
	couleur string,
	occasion string,
	prix int
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{"id":"_id"}')
TBLPROPERTIES('mongo.uri'='mongodb://localhost:27017/mongo_bigdata.immatriculation');


CREATE EXTERNAL TABLE mongo_client ( 
	id STRING,   
	age int,
	sexe STRING,
	taux int,
	situationFamiliale string,
	nbEnfantsAcharge int,
	deuxieme_voiture string,
	immatriculation string
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{"id":"_id"}')
TBLPROPERTIES('mongo.uri'='mongodb://localhost:27017/mongo_bigdata.client');