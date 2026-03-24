FROM kasmweb/core-ubuntu-noble:1.18.0-rolling-daily
USER root

ENV HOME=/home/kasm-default-profile
ENV STARTUPDIR=/dockerstartup
ENV INST_SCRIPTS=$STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

COPY ./src/netryx-astra/install $INST_SCRIPTS/netryx-astra/
RUN bash $INST_SCRIPTS/netryx-astra/install_netryx-astra.sh  && rm -rf $INST_SCRIPTS/netryx-astra/

COPY ./src/netryx-astra/resources/netryx-astra.png   /opt/Netryx-Astra-V2-Geolocation-Tool/netryx-astra.png
RUN chown 1000:1000 /opt/Netryx-Astra-V2-Geolocation-Tool/netryx-astra.png

COPY ./src/netryx-astra/startup/custom_startup.sh $STARTUPDIR/custom_startup.sh
RUN chmod +x $STARTUPDIR/custom_startup.sh

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME=/home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000