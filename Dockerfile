# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Set non-interactive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Update and install essential packages, including Java 17
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    build-essential \
    unzip \
    python3 \
    python3-pip \
    openjdk-17-jdk \
    cppcheck \
    nano \
    && apt-get clean

# Set Java 17 as the default
RUN update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-17-openjdk-amd64/bin/java 1 && \
    update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/java-17-openjdk-amd64/bin/javac 1

# Install Python static analysis tool Pylint
RUN pip install pylint

# Download and install SonarScanner
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.8.0.2856-linux.zip && \
    unzip sonar-scanner-cli-4.8.0.2856-linux.zip -d /opt && \
    ln -s /opt/sonar-scanner-4.8.0.2856-linux/bin/sonar-scanner /usr/bin/sonar-scanner

# Download the new SonarQube version
RUN wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-10.7.0.96327.zip -O /tmp/sonarqube.zip && \
    unzip /tmp/sonarqube.zip -d /opt && \
    rm /tmp/sonarqube.zip

# Create a non-root user
RUN groupadd -r sonar && useradd -r -g sonar sonar

# Create the home directory for sonar user and set permissions
RUN mkdir -p /home/sonar && chown -R sonar:sonar /home/sonar
RUN chown -R sonar:sonar /opt/sonarqube-10.7.0.96327

# Switch to the non-root user
USER sonar

# Set SonarQube path and permissions
WORKDIR /opt/sonarqube-10.7.0.96327/bin/linux-x86-64

# Expose SonarQube default port
EXPOSE 9000

# Default command: Start SonarQube
CMD ["/opt/sonarqube-10.7.0.96327/bin/linux-x86-64/sonar.sh", "console"]
