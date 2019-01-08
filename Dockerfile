FROM nginx:latest
    
RUN mkdir /etc/nginx/snippets
COPY ./snippets/* /etc/nginx/snippets/
COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY ./fastcgi_params /etc/nginx/fastcgi_params

COPY ./start.sh /root/start.sh
CMD ["/root/start.sh"]