FROM alpine:latest as builder
WORKDIR /workspace
COPY target/devops-integration.jar devops-integration.jar

# Stage 2: Create the final image
FROM openjdk:8-jdk-alpine
COPY --from=builder /workspace/devops-integration.jar devops-integration.jar
ENTRYPOINT ["java", "-jar", "devops-integration.jar"]
