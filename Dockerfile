FROM openjdk:alpine
WORKDIR /workspace/app1

COPY VERSION .
COPY target/spring-petclinic-2.7.0-SNAPSHOT.jar spring-petclinic-2.7.0-SNAPSHOT.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","spring-petclinic-2.7.0-SNAPSHOT.jar"]