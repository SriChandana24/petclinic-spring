FROM openjdk:alpine
WORKDIR /workspace/app

COPY target/spring-petclinic-2.7.0-SNAPSHOT.jar spring-petclinic-2.7.0-SNAPSHOT.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","spring-petclinic-2.7.0-SNAPSHOT.jar"]