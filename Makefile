# Makefile

config: env.sh setup-once.touch images.list

env.sh:
	cp env.sh.dist env.sh

setup-once.touch:
	./setup-project-once.sh

images.list:
	gcloud compute images list | egrep -v "windows|ric-cccwiki" | awk '{print $$1}' | grep -v NAME > images.list

run: config
	@echo "You should have a list of images. Feel free to edit them (if so press CTRL-C)"
	./create-vms.sh

clean:
	@echo Deleting all VMs...
	./cleanup.sh