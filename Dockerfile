# Stage 1: Build
FROM openjdk:8-alpine as build
WORKDIR /workspace
ADD target/devops-integration.jar devops-integration.jar

# Stage 2: Run
FROM openjdk:8-jre-alpine
EXPOSE 8080
COPY --from=build /workspace/devops-integration.jar devops-integration.jar
ENTRYPOINT ["java","-jar","/devops-integration.jar"]
