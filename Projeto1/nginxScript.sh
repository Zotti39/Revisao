echo "
server {
    listen 80;
    server_name minhaaplicacao.com;

    location / {
        proxy_pass http://localhost:5000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}" | sudo tee /etc/nginx/sites-available/myapp

### Ativar a configuração que definimos anteriormente e permite que o NGINX a utilize para servir as requisições.
sudo ln -s /etc/nginx/sites-available/myapp /etc/nginx/sites-enabled/

