FROM node:14
WORKDIR /usr/src/app
RUN npm init -y
RUN npm install express mysql
COPY . .
ENV HOST=0.0.0.0 PORT=3000
EXPOSE 3000
CMD [ "node", "app.js" ]
