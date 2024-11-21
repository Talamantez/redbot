FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && \
    apt-get install -y git build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set up working directory
WORKDIR /app

# Install Red-DiscordBot
RUN pip install -U pip setuptools wheel
RUN pip install Red-DiscordBot

# Set up basic config directory
RUN mkdir -p /app/data

# Create a setup script
RUN echo '#!/bin/bash\n\
echo "yes" | redbot-setup --no-prompt --instance-name docker --data-path /app/data \n\
redbot docker --token $TOKEN --prefix $PREFIX' > /app/start.sh && \
    chmod +x /app/start.sh

# Command to run the start script
CMD ["/app/start.sh"]