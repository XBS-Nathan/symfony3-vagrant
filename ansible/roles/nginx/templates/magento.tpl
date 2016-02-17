server {
    listen 80;

    server_name {{ server_name }};
    root        {{ doc_root }};


    location / {
        index index.php;
        try_files $uri $uri/ @handler;
    }


    # serve static files directly
    location ~* \.(jpg|jpeg|gif|png|css|js|ico|xml)$ {
        access_log        off;
        expires           30d;
    }

    location @handler { ## Magento uses a common front handler
        rewrite / /index.php;
    }

    location ~ \.php$ {
        if (!-e $request_filename) { rewrite / /index.php last; } ## Catch 404s that try_files miss

        fastcgi_intercept_errors off;
        fastcgi_pass  unix:/var/run/php5-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_script_name;
        fastcgi_read_timeout 180;
        include /etc/nginx/fastcgi_params;
    }

}
