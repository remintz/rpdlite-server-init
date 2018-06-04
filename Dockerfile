FROM nodered/node-red-docker:0.18.7-v8
USER root
RUN npm install node-red-dashboard
RUN npm install node-red-node-twilio
RUN npm install node-red-node-mongodb
EXPOSE 1880
CMD ["npm", "start", "--", "--userDir", "/data"]