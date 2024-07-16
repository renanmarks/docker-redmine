#!/bin/bash

/etc/init.d/ssh status

if [  "$?" != 0 ]; then
	/etc/init.d/ssh restart
fi

if [ ! -f /home/redmine/done ]; then
	echo "[SETUP_GITOLITE] Installing the redmine keys..."
	su - git -c "gitolite setup -pk /home/redmine/ssh_keys/redmine_gitolite_admin_id_rsa.pub"
	
	echo "[SETUP_GITOLITE] Updating the configuration..."
	su - git -c "sed -i -E \"s/(RW\+[[:space:]]+=[[:space:]]+)admin/\1redmine_gitolite_admin_id_rsa/g\" /home/git/.gitolite/conf/gitolite.conf"

	echo "[SETUP_GITOLITE] Trying to connect to Gitolite showing information ..."
	su - redmine -c "ssh -o StrictHostKeyChecking=accept-new -i ssh_keys/redmine_gitolite_admin_id_rsa git@localhost info"
	
	echo "[SETUP_GITOLITE] Configuring Redmine user as admin..."
	su - redmine -c "git clone git@localhost:gitolite-admin.git && cd gitolite-admin && sed -i -E \"s/(RW\+[[:space:]]+=[[:space:]]+)admin/\1redmine_gitolite_admin_id_rsa/g\" conf/gitolite.conf && git add . && git config user.email \"redmine@admin.com\" && git config user.name \"Redmine Admin\" && git commit -a -m \"Add Redmine permission on gitolite-admin repo.\" && git push"

	echo "[SETUP_GITOLITE] Cleaning..."
	rm -rf gitolite-admin
	su - redmine -c "touch done"
fi

/docker-entrypoint.sh $@
