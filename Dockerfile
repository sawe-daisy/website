# Stage 1: Compile and Build angular codebase
#4b7c359ce288
# Use official node image as the base image
FROM node:14-alpine as build-step

# Set the working directory on the container
WORKDIR /usr/local/app

# Add the source code to app
COPY ./ /usr/local/app/

# Install all the dependencies

RUN npm install


# Generate the build of the application
RUN npm run build

# RUN apt-get update && apt-get install -y redis-server

# Stage 2: Serve app with nginx server

# Use official nginx image as the base image
FROM nginx:1.17.1-alpine

# Copy the build output to replace the default nginx contents.
COPY --from=build-step /usr/local/app/dist/website /usr/share/nginx/html

# Expose port 80
EXPOSE 80