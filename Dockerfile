# Build stage
FROM node:20-alpine AS stage1
#Set working directory
WORKDIR /app
COPY package*.json ./
#Download the dependencies written in the package.json and package-lock.json
RUN npm ci
#Copy Everything from current dir. to the /app
COPY . .
#Build the application
RUN npm run build
#change image to nginx
FROM nginx:alpine
#Copy data from "stage1" build
COPY --from=stage1 /app/dist /usr/share/nginx/html
#expose application on it's respective port
EXPOSE 80
#Run the container Docker file by RahulSaini :)
CMD ["nginx", "-g", "daemon off;"]
