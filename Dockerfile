FROM nubomedia/apps-baseimage:src

MAINTAINER Nubomedia

RUN chown -R nubomedia:nubomedia /home/nubomedia
USER 1000
RUN mkdir -p /home/nubomedia/.m2
ADD settings.xml /home/nubomedia/.m2/
RUN git config --global http.sslverify "false"
RUN git clone https://github.com/Kurento/kurento-java.git /home/nubomedia/kurento-java
RUN cd /home/nubomedia/kurento-java $$ mvn install -DskipTests -Pdefault
ADD kurento-tree-demo-embed/ /home/nubomedia/kurento-tree-demo-embed
RUN sudo chown -R nubomedia:nubomedia /home/nubomedia/kurento-tree-demo-embed && cd /home/nubomedia/kurento-tree-demo-embed && mvn compile

EXPOSE 8443/tcp 8088/tcp 443/tcp
ENTRYPOINT cd /home/nubomedia/kurento-tree-demo-embed && mvn exec:java
