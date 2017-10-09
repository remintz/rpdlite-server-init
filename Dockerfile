FROM nodered/node-red-docker
USER root
RUN npm install node-red-dashboard
RUN npm install node-red-node-twilio
EXPOSE 1880
CMD ["npm", "start", "--", "--userDir", "/data"]