# Stage 1: Build
FROM openjdk:8-alpine as build
WORKDIR /workspace
COPY target/devops-integration.jar devops-integration.jar

# Stage 2: Run
FROM gcr.io/distroless/java:8
COPY --from=build /workspace/devops-integration.jar devops-integration.jar
CMD ["devops-integration.jar"]
