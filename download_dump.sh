heroku pgbackups:capture --expire -a usecurrently
 
curl -o latest.dump `heroku pgbackups:url -a usecurrently`

pg_restore --verbose --clean --no-acl --no-owner -h localhost -d currently_development latest.dump

rm ./latest.dump

echo 'New Data Ready'