# Using Ubuntu, it have nice out of the box tools
# and Chef have downloads of binaries for it
# Taking my chances on rolling tags :-(
FROM ubuntu:14.04


RUN apt-get update && apt-get install -y \
  wget \
  && rm -rf /var/lib/apt/lists/*

# Thank to Chef for using "_" for download URL it is not really easy to concatenate strings, so using complete name
ENV CHEF_DK_PACKAGE chefdk_0.17.17-1_amd64.deb

# Download Chef Development Kit, Ubuntu 12.04, 13.04 and 14.04 compatible:
RUN wget https://packages.chef.io/stable/ubuntu/12.04/${CHEF_DK_PACKAGE}

# Run install command:
RUN dpkg -i ${CHEF_DK_PACKAGE}

# Setting entry point to the chefdk cmd and default to help
# Easy to use this image then as command line tool
# as docker run containername will do chef --help
# while anyting else will use the chef cmd, e.g.
# docker run containername env (equal to chef env)
ENTRYPOINT ["chef"]
CMD ["--help"]
