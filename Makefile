# Makefile


list:
	bin/gcs-list.sh

config: env.sh setup-once.touch images.list

env.sh:
	cp env.sh.dist env.sh

setup-once.touch:
	bin/setup-project-once.sh

images.list:
	# You might want to also remove your own project id? maybe not.
	gcloud compute images list | egrep -v "windows" | awk '{print $$1}' | grep -v NAME > images.list

run: config
	@echo "You should have a list of images. Feel free to edit them (if so press CTRL-C)"
	bin/create-vms.sh

clean:
	@echo Deleting all VMs...
	bin/cleanup.sh
