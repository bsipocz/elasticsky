FROM rayproject/ray:latest-cpu
MAINTAINER Mario Juric

# Useful utilities
RUN apt-get update \
	&& apt-get install joe jq -y

# Update applications and install OS-level dependencies
RUN apt-get update \
	&& apt-get install g++ make wget libncurses5-dev libcurl4-openssl-dev git -y

# Download and install find_orb and dependencies
RUN mkdir ~/software && cd ~/software \
	&& git clone https://github.com/Bill-Gray/find_orb.git \
	&& cd find_orb \
	&& /bin/bash DOWNLOAD.sh -d .. \
	&& /bin/bash INSTALL.sh -d .. -u \
	&& cp -a ~/bin/* /usr/local/bin \
	&& rm -r ~/software

# elasticsky dependencies
RUN conda install -c defaults -c conda-forge tabulate flask-restful --yes \
 	&& conda clean --all --yes

# elasticsky data
COPY environ.dat /data/
COPY tv/index.html /data/tv/
COPY tv/trace_viewer_full.html /data/tv/

WORKDIR /data
