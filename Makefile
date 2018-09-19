#                                 __                 __
#    __  ______  ____ ___  ____ _/ /____  ____  ____/ /
#   / / / / __ \/ __ `__ \/ __ `/ __/ _ \/ __ \/ __  /
#  / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
#  \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
# /____                     matthewdavis.io, holla!
#
include .make/Makefile.inc

APP		?= vernemq
NS		?= default
USER	?= mqtt

setup:

	mkdir -p secrets
	touch secrets/vmq.passwd

	docker run --rm -v $(PWD)/secrets:/mnt -it erlio/docker-vernemq vmq-passwd /mnt/vmq.passwd $(USER)

	kubectl create secret generic vernemq-passwd --from-file=./secrets/vmq.passwd
	
	openssl req -new -x509 -days 365 -extensions v3_ca -keyout secrets/ca.key -out secrets/ca.crt
	openssl genrsa -out secrets/server.key 2048
	openssl req -out secrets/server.csr -key secrets/server.key -new
	openssl x509 -req -in secrets/server.csr -CA secrets/ca.crt -CAkey secrets/ca.key -CAcreateserial -out secrets/server.crt -days 365

	kubectl create secret generic vernemq-certifications --from-file=./secrets/ca.crt --from-file=./secrets/server.crt --from-file=./secrets/server.key

test:

	kubectl exec vernemq-1 -- vmq-admin cluster show