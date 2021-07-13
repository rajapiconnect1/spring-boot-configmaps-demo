FROM openjdk:8-jdk-alpine

VOLUME /tmp

EXPOSE 8080

ARG JAR_FILE=target/spring-boot-configmaps-demo-0.0.1-SNAPSHOT.jar

ADD ${JAR_FILE} spring-boot-configmaps-demo-0.0.1-SNAPSHOT.jar

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/spring-boot-configmaps-demo-0.0.1-SNAPSHOT.jar"]
