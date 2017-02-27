# www.smostert.com, smostert.com, *.smostert.com
server {
        listen 80;
        listen [::]:80;

        root /var/www/html/smostert_com;
        server_name www.smostert.com *.smostert.com smostert.com default_server;

        index index.php index.html index.htm;



        include /etc/nginx/smostert_general.conf;

        location / {
                try_files $uri $uri/ =404;
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
