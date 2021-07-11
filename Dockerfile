FROM adoptopenjdk/openjdk8-openj9 
RUN apt-get update && \
    apt-get install -y maven unzip

COPY . /project
WORKDIR /project

#RUN mvn -X initialize process-resources verify => to get dependencies from maven
#RUN mvn clean package	
#RUN mvn --version
RUN mvn clean package

RUN ls target

#ARG JAR_FILE=target/*.jar
COPY ./target/spring-boot-configmaps-demo-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]