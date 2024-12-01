# Stage 1: Build Stage
FROM node:18-alpine AS build

# Set working directory in the container
WORKDIR /app

# Copy application files to the container
COPY my-react-app/ .

# Install dependencies
RUN npm install

# Build the React application
RUN npm run build


# Stage 2: Production Stage
FROM nginx:stable

# Set working directory in the container
WORKDIR /usr/share/nginx/html

# Remove the default nginx static assets
RUN rm -rf ./*

# Copy built files from the build stage to Nginx
COPY --from=build /app/dist .

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
