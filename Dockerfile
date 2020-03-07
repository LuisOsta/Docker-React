# BUILD STEP
FROM node:alpine as builder

WORKDIR /app

COPY package.json .
RUN npm install
COPY . .
RUN ["npm", "run", "build"]

# RUN STEP.
# The NGINX container will automatically startup the server based on whats on the html dir
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html