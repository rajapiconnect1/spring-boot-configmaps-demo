
# Stage and thin the application 
FROM openliberty/open-liberty:full-java11-openj9-ubi as staging

COPY --chown=1001:0 target/spring-boot-configmaps-demo-0.0.1-SNAPSHOT.jar \
                    /staging/fat-spring-boot-configmaps-demo-0.0.1-SNAPSHOT.jar

RUN springBootUtility thin \
 --sourceAppPath=/staging/fat-spring-boot-configmaps-demo-0.0.1-SNAPSHOT.jar \
 --targetThinAppPath=/staging/thin-spring-boot-configmaps-demo-0.0.1-SNAPSHOT.jar \
 --targetLibCachePath=/staging/lib.index.cache

# Build the image
FROM openliberty/open-liberty:full-java11-openj9-ubi

ARG VERSION=1.0
ARG REVISION=SNAPSHOT

COPY --chown=1001:0 src/main/liberty/config /config/


COPY --chown=1001:0 --from=staging /staging/lib.index.cache /lib.index.cache
COPY --chown=1001:0 --from=staging /staging/thin-spring-boot-configmaps-demo-0.0.1-SNAPSHOT.jar  \
                    /config/dropins/spring/thin-spring-boot-configmaps-demo-0.0.1-SNAPSHOT.jar

RUN configure.sh 


RUN features.sh