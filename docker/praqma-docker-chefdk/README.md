# Praqma Chef DK docker image

We haven't published this yet, so you need to build your own local image to use it:

	docker build -t praqma/chefdk:snapshot -rm .

_Note the "." - pointing to Dockerfile, so assuming you are in the same folder at the Dockerfile_.


## Use Chef DK from image

Entrypoint and cmd have been configured so it assumes you always run chef command:

	docker run --rm praqma/chefdk:snapshot 

is equal to running `chef` which means `chef --help`

	docker run praqma/chefdk:snapshot env

is equal to `chef env`

_Did you name your image only chef, it would be `docker run --rm chef env` which might be more descriptive_

You could also wrap a Bash alias or like.

## Publishing a container

We can consider publishing an official container.

Our github repo should be in Praqma org, and name should be docker-chefdk, which means the docker image will be praqma/chefdk.
