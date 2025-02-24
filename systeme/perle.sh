#!/bin/bash
#paramètres de connexion mysql
DB_NAME="telecom_employées"
TABLE_NAME="employées"
DB_USER="root"
DB_PASS=""

#pour afficher le menu principal
menu() {
echo "Gestion des employés"
echo "1. Créer la base de données et la table"
echo "2. Ajouter un nouvel employé"
echo "3. Mettre a jour les informations d'un employé existant"
echo "4. Supprimer un employé"
echo "5. Afficher la liste des employés"
echo "6. Quitter"
}

#pour créer la base de données et la table
créer_db_et_table() {
mysql -u $DB_USER -p$DB_PASS -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mysql -u $DB_USER -p$DB_PASS -e "USE $DB_NAME; CREATE TABLE IF NOT EXISTS $TABLE_NAME (id INT AUTO_INCREMENT PRIMARY KEY,prénom VARCHAR(100) NOT NULL,nom VARCHAR(100) NOT NULL,poste VARCHAR(100) NOT NULL,département VARCHAR(100),salaire DECIMAL(10, 2),date_embauche DATE NOT NULL);"
}

#pour ajouter un nouvel employé
ajout_employé(){
echo "Entrez le prénom de l’employé :"
read prenom
echo "Entrez le nom de l’employé :"
read nom
echo "Entrez le poste de l’employé :"
read poste
echo "Entrez le département dans lequel travaille l’employé :"
read departement
echo "Entrez le salaire de l’employé :"
read salaire
echo "Entrez la date d'embauche de l’employé (AAAA-MM-JJ):"
read date_embauche
mysql -u $DB_USER -p$DB_PASS -e "USE $DB_NAME; INSERT INTO $TABLE_NAME (prénom, nom, poste, département, salaire, date_embauche) VALUES ('$prenom', '$nom', '$poste', '$departement', '$salaire', '$date_embauche');"
echo "Employé ajouté avec succès." 
}

#pour mettre a jour un employé existant
mettre_a_jour_employé() {
echo "Entrez l'id de l’employé a mettre a jour :"
read id
echo "Entrez le nouveau prénom :"
read prenom
echo "Entrez le nouveau nom :"
read nom
echo "Entrez le nouveau poste :"
read poste
echo "Entrez le nouveau département :"
read departement
echo "Entrez le nouveau salaire :"
read salaire
echo "Entrez la nouvelle date d'embauche (AAAA-MM-JJ):"
read date_embauche
if [ ! -z "$prenom" ]; then
mysql -u $DB_USER -p$DB_PASS -e "USE $DB_NAME; UPDATE $TABLE_NAME SET prenom='$prenom' WHERE id=$id;"
fi
if [ ! -z "$nom" ]; then
mysql -u $DB_USER -p$DB_PASS -e "USE $DB_NAME; UPDATE $TABLE_NAME SET nom='$nom' WHERE id=$id;"
fi
if [ ! -z "$poste" ]; then
mysql -u $DB_USER -p$DB_PASS -e "USE $DB_NAME; UPDATE $TABLE_NAME SET poste='$poste' WHERE id=$id;"
fi
if [ ! -z "$departement" ]; then
mysql -u $DB_USER -p$DB_PASS -e "USE $DB_NAME; UPDATE $TABLE_NAME SET departement='$departement' WHERE id=$id;"
fi
if [ ! -z "$salaire" ]; then
mysql -u $DB_USER -p$DB_PASS -e "USE $DB_NAME; UPDATE $TABLE_NAME SET salaire='$salaire' WHERE id=$id;"
fi
if [ ! -z "$date_embauche" ]; then
mysql -u $DB_USER -p$DB_PASS -e "USE $DB_NAME; UPDATE $TABLE_NAME SET date_embauche='$date_embauche' WHERE id=$id;"
fi
echo "Employé mis a jour."
}

#pour supprimer un employé
supprimer_employe() {
echo "Entrez l'id de l’employé a supprimer :"
read id
mysql -u $DB_USER -p$DB_PASS -e "USE $DB_NAME; DELETE FROM $TABLE_NAME WHERE id=$id;"
echo "employé supprimer avec succès."
}

#pour afficher les employés
afficher_employés() {
mysql -u $DB_USER -p$DB_PASS -e "USE $DB_NAME; SELECT * FROM $TABLE_NAME;"
}

#la boucle principale
while true; do
menu
read -p "votre choix : " choix

case $choix in 
1) créer_db_et_table ;;
2) ajout_employé ;;
3) mettre_a_jour_employé ;;
4) supprimer_employe ;;
5) afficher_employés ;;
6) break ;;
*) echo "option invalide" ;;
esac
done
