# data.smostert.com
server {
        listen 80;
        listen [::]:80;

        root /var/web-data/data;
        server_name data.smostert.com;

        index index.html index.htm;


        include /etc/nginx/smostert_general.conf;

        location / {
                try_files $uri $uri/ =404;
                autoindex on;
        }

}
