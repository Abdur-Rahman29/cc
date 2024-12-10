# Use Rocky Linux 8 as the base image
FROM rockylinux:8

# Set environment variables
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk

# Update the system and install required packages
RUN yum update -y && \
    yum install -y java-11-openjdk-devel python3 python3-pip && \
    yum clean all

# Set the working directory inside the container
WORKDIR /app

# Copy the application files into the container
COPY . /app

# Install Python dependencies (ensure requirements.txt exists in your app directory)
RUN pip3 install --no-cache-dir -r requirements.txt

# Expose a port (change 5000 to your application's port if needed)
EXPOSE 5000

# Define the default command to run your app
CMD ["python3", "app.py"]
