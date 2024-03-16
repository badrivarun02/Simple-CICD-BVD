FROM openjdk:8-alpine as build
WORKDIR /workspace
COPY target/devops-integration.jar devops-integration.jar

# Stage 2: Create the final image
FROM alpine:latest
COPY --from=build /workspace/devops-integration.jar devops-integration.jar
ENTRYPOINT ["java", "-jar", "devops-integration.jar"]
