# Use a Red Hat-based base image
FROM centos:7

# Update packages and install Java and Python
RUN yum update -y && \
    yum install -y java-11-openjdk-devel python3 python3-pip && \
    yum clean all

# Set JAVA_HOME for the environment
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk
ENV PATH=$JAVA_HOME/bin:$PATH

# Install Python dependencies
COPY requirements.txt /app/requirements.txt
RUN pip3 install --no-cache-dir -r /app/requirements.txt

# Copy application code to the container
COPY . /app

# Set the working directory
WORKDIR /app

# Expose the desired port (replace 8080 if necessary)
EXPOSE 9090

# Command to run your Python application
CMD ["python3", "app.py"]
