FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
# This is pulling stuff from the previous phase. The target dir is the nginx default.
COPY --from=builder /app/build /usr/share/nginx/html
# nginx handles RUN by itself, so we do not need to do a RUN for this one