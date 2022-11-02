FROM node:14.14.0-alpine as build
WORKDIR /app
COPY ./package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
EXPOSE 3000
COPY --from=build /app/build /usr/share/nginx/html

