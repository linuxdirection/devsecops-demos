# Use the official Node.js 14 image.
FROM node:14

# Create and change to the app directory.
WORKDIR /usr/src/app

# Initialize a new npm project. The -y flag will auto-generate a default package.json file.
RUN npm init -y

# Install application dependencies.
RUN npm install express express-session body-parser

# Copy the local code to the container image.
COPY . .

# The port the app will run on.
EXPOSE 3000

# The command to run the application.
CMD ["node", "app.js"]
