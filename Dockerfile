FROM ubuntu:20.04
#install working environment
RUN apt update -y && apt install -y wget openjdk-11-jdk

###prevent user interaction while Configuring tzdata
RUN DEBIAN_FRONTEND=noninteractive TZ=Europe/Paris apt-get -y install tzdata

#Tomcat installation
RUN mkdir /usr/local/tomcat
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.70/bin/apache-tomcat-9.0.70.tar.gz -O /tmp/tomcat.tar.gz
RUN cd /tmp && tar xvfz tomcat.tar.gz
RUN cp -Rv /tmp/apache-tomcat-9.0.70/* /usr/local/tomcat/
#Apache  should listen port 8080
EXPOSE 8080

#copy war artifact to the Tomcat directory for run
#WORKDIR /usr/src/mymaven/
COPY *.war /usr/local/tomcat/webapps/
#COPY /target/*.war /usr/local/tomcat/webapps/
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
