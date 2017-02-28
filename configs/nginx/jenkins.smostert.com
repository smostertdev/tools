
# jenkins.smostert.com
server {
        listen 80;
        listen [::]:80;

        server_name jenkins.smostert.com;

        index index.cgi index.php index.html index.htm;

        include /etc/nginx/smostert_general.conf;

        location / {
                proxy_set_header        Host $host:$server_port;
                proxy_set_header        X-Real-IP $remote_addr;
                proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header        X-Forwarded-Proto $scheme;
                proxy_pass          http://127.0.0.1:8080;
                proxy_read_timeout  90;
                proxy_redirect      http://127.0.0.1:8080 http://jenkins.smostert.com;
        }

        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/var/run/php5-fpm.sock;
        }

        location ~ \.cgi$ {
                fastcgi_pass  unix:/var/run/fcgiwrap.socket;
                fastcgi_index index.cgi;
                include /etc/nginx/fastcgi_params;
        }
}

