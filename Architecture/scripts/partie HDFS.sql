==========================================HDFS=================================================

### Lancer YARN et HDFS
start-dfs.sh
start-yarn.sh

### creation un dossier pour chaque fichier csv
hdfs dfs -mkdir /marketing
hdfs dfs -mkdir /client
hdfs dfs -mkdir /immatriculation
hdfs dfs -mkdir /catalogue

### Transferer fichier csv de vagrant a HDFS
hdfs dfs -put Marketing.csv /marketing/marketing.csv
hdfs dfs -put Clients_11.csv /client/client.csv
hdfs dfs -put Catalogue.csv /catalogue/catalogue.csv
hdfs dfs -put Immatriculation.csv /immatriculation/immatriculation.csv

