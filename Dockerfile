# Use the latest stable Node.js image as the base (replace with the latest version if necessary)
FROM node:latest

# Install dependencies for Chromium
RUN apt-get update && \
    apt-get install -y \
    chromium \
    fonts-liberation \
    libappindicator3-1 \
    libnss3 \
    && rm -rf /var/lib/apt/lists/*

# Set working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json for faster builds
COPY package*.json ./

# Install dependencies
RUN npm install --force

# Copy the rest of the application files to the container
COPY . .

# Build the application
RUN npm run build

# Expose port 3001
EXPOSE 3001

# Start the server using PM2
CMD ["npm", "run", "start-server"]
