# pull official base image
#FROM node:14-alpine3.12 as build
FROM node:current-alpine3.16 as build

#working directory of containerized app
WORKDIR /app

#copy the react app to the container
COPY . /app/

#prepare the container for building react

#RUN npm cache clean --force

RUN npm install --legacy-peer-deps
# RUN npm install react-search-field --save

RUN npm run build

#prepare nginx

FROM nginx:1.16.0-alpine
COPY --from=build /dist/pet-zey-app /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx/nginx.conf /etc/nginx/conf.d

#fire for nginx
EXPOSE 80
CMD [ "nginx","-g","daemon off;" ]