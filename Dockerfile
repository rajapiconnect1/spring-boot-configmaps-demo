FROM adoptopenjdk/openjdk8-openj9 
RUN apt-get update && \
    apt-get install -y maven unzip

#COPY . /project
#WORKDIR /project

#RUN mvn -X initialize process-resources verify => to get dependencies from maven
#RUN mvn clean package	
#RUN mvn --version
RUN mvn clean package

RUN ls target
RUN pwd

#ARG JAR_FILE=target/*.jar
COPY /target/*.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]