# drupal.smostert.com
server {
        listen 80;
        listen [::]:80;

        root /var/web-data/drupal;
        server_name drupal.smostert.com;

        index index.php index.html index.htm;



        include /etc/nginx/smostert_general.conf;

        location / {
                try_files $uri $uri/ =404;
        }

        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/var/run/php5-fpm.sock;
        }
}
