FROM maven:3.6.3-openjdk-11 AS maven
RUN apt-get update -y && apt-get upgrade -y && apt-get install git -y && apt-get install unzip -y
WORKDIR /opt
RUN https://dlcdn.apache.org/tomcat/tomcat-10/v10.0.12/bin/apache-tomcat-10.0.12-windows-x64.zip
RUN  unzip apache-tomcat-10.0.12-windows-x64.zip
RUN mv apache-tomcat-10.0.12 tomcat10
RUN chmod -R 700 tomcat
WORKDIR /opt
RUN git clone https://github.com/pjagannadha4/petclinic-ci-cd.git
WORKDIR /opt/spring-framework-petclinic
RUN mvn clean package
WORKDIR /opt/spring-framework-petclinic/target
RUN cp -R petclinic.war /opt/tomcat/webapps/
EXPOSE 8080
CMD chmod +x /opt/tomcat/bin/catalina.sh
CMD /opt/tomcat/bin/catalina.sh run
