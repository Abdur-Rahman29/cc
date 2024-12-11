# Use Rocky Linux 8 as the base image
FROM rockylinux:8

# Set environment variables
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk
ENV GRADLE_USER_HOME=/app/.gradle  # Set Gradle home to a writable directory

# Update the system and install required packages
RUN yum update -y && \
    yum install -y java-11-openjdk-devel python3 python3-pip && \
    yum clean all

# Set the working directory inside the container
WORKDIR /app

# Copy the application files into the container
COPY . /app

# Give executable permission to gradlew
RUN chmod +x gradlew

# Expose a port (change 9090 to your application's port if needed)
EXPOSE 9090

# Define the default command to run your app
CMD ["python3", "app.py"]
