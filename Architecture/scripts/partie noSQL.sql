=========================================NoSQL DB KVStore====================================================
### lancer vagrant
vagrant up
### Trensferer les fichiers csv dans vagrant
vagrant scp Clients_11.csv oracle-21c-vagrant:/vagrant
### Acceder a MV
vagrant ssh

### lancer hdfs et yarn
start-dfs.sh
start-yarn.sh

### KVstore utiliser KVLite
nohup java -Xmx256m -Xms256m -jar $KVHOME/lib/kvstore.jar kvlite -secure-config disable -root $KVROOT > kvstore.log 2>&1 &

### SQL shell
java -Xmx256m -Xms256m -jar $KVHOME/lib/sql.jar -helper-hosts localhost:5000 -store kvstore
-------------------------Craetion des tables-----------------
CREATE table nosql_marketing(
	AGE INTEGER, 
	SEXE ENUM(M,F,vide) DEFAULT vide,
	TAUX INTEGER,
	SITUATION_FAMILIALE ENUM (vide,Celibataire, Divorcee,En_Couple, Marie,Seul,Seule) DEFAULT vide,
	NB_ENFANTS_ACHARGE INTEGER,
	DEUXIEME_VOITURE BOOLEAN,
	PRIMARY KEY(AGE)
);


CREATE table nosql_client11(
	AGE INTEGER, 
	SEXE ENUM(M,F,vide) DEFAULT vide,
	TAUX INTEGER,
	SITUATION_FAMILIALE ENUM (Celibataire, Divorcee,En_Couple, Marie,Seul,Seule,vide) DEFAULT vide,
	NB_ENFANTS_ACHARGE INTEGER,
	DEUXIEME_VOITURE BOOLEAN,
	IMMATRICULATION STRING,
	PRIMARY KEY(AGE)
);

CREATE table nosql_immatriculation(
	IMMATRICULATION STRING,
	MARQUE STRING, 
	NOM STRING,
	PUISSANCE INTEGER,
	LONGEUR ENUM (courte, moyenne, longue, tres_longue),
	NBPLACES INTEGER,
	NBPORTES INTEGER,
	COULEUR ENUM (blanc, bleu, gris, noir, rouge),
	OCCASION BOOLEAN,
	PRIX INTEGER,
	PRIMARY KEY(IMMATRICULATION)
);


CREATE table nosql_catalogue (  
	MARQUE STRING,
	NOM STRING,
	PUISSANCE INTEGER,
	longueur ENUM (courte, moyenne, longue, tres_longue),
	nbPlaces STRING,
	nbPortes STRING,
	COULEUR STRING,
	OCCASION BOOLEAN,
	PRIX INTEGER,
	PRIMARY KEY(MARQUE)
);

------------------------------------Remplissage des table ------------------------------
sql-> import -table nosql_catalogue -file CatalogueSave.csv CSV
sql-> import -table nosql_immatriculation -file Immatriculations.csv CSV
sql-> import -table nosql_client -file Client.csv CSV
sql-> import -table nosql_marketing -file Marketing.csv CSV