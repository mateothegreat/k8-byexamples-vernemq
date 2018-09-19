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

setup:

	mkdir -p secrets
	touch secrets/vmq.passwd
	docker run --rm -v $(PWD)/secrets:/mnt -it erlio/docker-vernemq vmq-passwd /mnt/vmq.passwd inner
	docker run --rm -v $(PWD)/secrets:/mnt -it erlio/docker-vernemq vmq-passwd /mnt/vmq.passwd outer

	kubectl create secret generic vernemq-passwd --from-file=./secrets/vmq.passwd
	
test:

	kubectl exec vernemq-1 -- vmq-admin cluster show