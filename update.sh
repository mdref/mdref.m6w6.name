#!/bin/bash

# pull the app and all refs
git submodule foreach "git pull -qr origin master"

cd refs
for ref in http pq; do 
	../mdref/bin/ref2stub $ref >/dev/null

	# this is semantically awful
	if ! diff -q {,$ref/}$ref.stub.php; then
		cp {,$ref/}$ref.stub.php
		(cd $ref && git commit -am "update live stub" && git push)
	fi
done
cd ..
git ci -am "update live" && git push
