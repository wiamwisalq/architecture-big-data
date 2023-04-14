===============================================MongoDB=======================================================


### lancer mongoDB 
sudo systemctl start mongod
### connecter a mongoDB
mongo

### creation d'une BD et l'utiliser

use bigdata

### Creation des collections

db.createCollection("marketing")
db.createCollection("client")
db.createCollection("immatriculation")
db.createCollection("catalogue")


------------------------------------------Remplissage des collections par les fichiers csv-------------------

mongoimport --db mongo_bigdata --collection marketing --type csv --file Marketing.csv --headerline

mongoimport --db mongo_bigdata --collection client --type csv --file Clients_11.csv --fields "age,sexe,taux,situationFamiliale,nbEnfantsAcharge,deuxieme_voiture,immatriculation"

mongoimport --db mongo_bigdata --collection catalogue --type csv --file Catalogue.csv --headerline

mongoimport --db mongo_bigdata --collection immatriculation --type csv --file Immatriculations.csv --fields "immatriculation","marque","nom","puissance","longueur","nbPlaces","nbPortes","couleur","occasion","prix"

----------------------------l'affichage------------------------------------

db.client.find({}) // pour afficher tous
db.immatriculation.findOne()