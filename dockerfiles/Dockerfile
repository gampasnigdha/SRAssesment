FROM ubuntu
RUN apt-get update
RUN apt-get install nginx -y
COPY index.html /var/www/html/
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
EXPOSE 80
#CMD service nginx start
CMD ["nginx"]
