# Makefile

config: env.sh setup-once.touch

env.sh:
	cp env.sh.dist env.sh

setup-once.touch:
	./setup-project-once.sh
	

run: config
	./create-vms.sh