# Stage 1: Build the application
# Use the latest version of the Alpine Linux image as the base image for this stage.
# This image is named 'builder'.
FROM alpine:latest as builder

# Set the working directory in the Docker image to '/workspace'. 
# All subsequent commands (like COPY) will be run in this directory.
WORKDIR /workspace

# Copy the 'devops-integration.jar' file from the 'target' directory of the host machine 
# to the current directory ('/workspace') in the Docker image.
COPY target/devops-integration.jar devops-integration.jar

# Stage 2: Create the final image
# Use the 'openjdk:8-jre-alpine' image as the base image for this stage. 
# This image includes the Java Runtime Environment (JRE) on an Alpine Linux base, 
# which is needed to run your Java application.
FROM openjdk:8-jre-alpine 

# Copy the 'devops-integration.jar' file from the '/workspace' directory in the 'builder' image 
# (the first stage) to the current directory in the Docker image.
COPY --from=builder /workspace/devops-integration.jar devops-integration.jar

# Set the default command for the Docker container to 'java -jar devops-integration.jar'. 
# This command will be run when a container is started from the Docker image.
ENTRYPOINT ["java", "-jar", "devops-integration.jar"]
