# Use Node.js 14 as base image
FROM node:14

# Set working directory to /app
WORKDIR /app

# Copy all source code to the working directory
COPY . .

# Set environment variables:
# - NODE_ENV=production to run in production mode
# - DB_HOST=item-db to connect to the MongoDB container
ENV NODE_ENV=production DB_HOST=item-db

# Install production dependencies (--production flag) and build the application
# The --unsafe-perm flag allows running npm as root
RUN npm install --production --unsafe-perm && npm run build

# Expose port 8080 to be accessible from other containers/host
EXPOSE 8080

# Command to run when container starts
# This will execute "npm start" to start the Node.js server
CMD ["npm", "start"]