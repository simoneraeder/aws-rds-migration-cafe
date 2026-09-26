ls
mysqldump --user=root --password='Re:Start!9' --databases cafe_db --add-drop-database > cafedb-backup.sql
ls
less cafedb-backup.sql
curl -o global-bundle.pem https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem
mysql --user=root --password='Re:Start!9' --host=<RDS Instance Database Endpoint Address> --ssl-ca=./global-bundle.pem < cafedb-backup.sql
mysql --user=root --password='Re:Start!9' --host= cafedbinstance.cii4isbettbv.us-west-2.rds.amazonaws.com --ssl-ca=./global-bundle.pem < cafedb-backup.sql
mysql --user=root --password='Re:Start!9' --host= cafedbinstance.cii4isbettbv.us-west-2.rds.amazonaws.com --ssl-ca=./global-bundle.pem < cafedb-backup.sqlmysql --user=root --password='Re:Start!9' --host=cafedbinstance.cii4isbettbv.us-west-2.rds.amazonaws.com --ssl-ca=./global-bundle.pem < cafedb-backup.sqlclear
clear
mysql --user=root --password='Re:Start!9' --host=cafedbinstance.cii4isbettbv.us-west-2.rds.amazonaws.com --ssl-ca=./global-bundle.pem < cafedb-backup.sql
mysql --user=root --password='Re:Start!9' --host=cafedbinstance.cii4isbettbv.us-west-2.rds.amazonaws.com --ssl-ca=./global-bundle.pem cafe_db
aws rds create-db-parameter-group   --db-parameter-group-name cafedb-params   --db-parameter-group-family mariadb10.11   --description "Parametros do CafeDB permitindo conexao sem SSL"
mysql --user=root --password='Re:Start!9'   --host=cafedbinstance.cii4isbettbv.us-west-2.rds.amazonaws.com   cafe_db
mysql --user=root --password='Re:Start!9'   --host=cafedbinstance.cii4isbettbv.us-west-2.rds.amazonaws.com   cafe_db
mysql --user=root --password='Re:Start!9'   --host=cafedbinstance.cii4isbettbv.us-west-2.rds.amazonaws.com   cafe_db
