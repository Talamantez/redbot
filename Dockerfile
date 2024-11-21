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

# Command to run the bot
CMD ["redbot", "docker", "--token", "$TOKEN", "--prefix", "$PREFIX"]