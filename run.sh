#!/bin/sh

if [ -f /data/WiredTiger ]
then

	mongod --auth --port 27017 --dbpath /data

else

	mongod --dbpath /data &

	RET=1
	while [ $RET != 0 ]; do
	    echo "=> Waiting for confirmation of MongoDB service startup"
	    sleep 5
	    mongo admin --eval "help" >/dev/null 2>&1
	    RET=$?
	done

	echo "=> Creating an admin user in MongoDB"
	mongo admin --eval "db.createUser({user: '"${ADMINUSER}"', pwd: '"${ADMINPASS}"', roles: [{role: 'root', db: 'admin'}]});"
	mongo vl --eval "db.createUser({user: '"${REGULARUSER}"', pwd: '"${REGULARPASS}"', roles: [{role: 'readWrite', db: 'vl'}, {role: 'read', db: 'reporting'}]});"

	mongod --dbpath /data --shutdown

	mongod --auth --port 27017 --dbpath /data

fi