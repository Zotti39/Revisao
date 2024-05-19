### O arquivo criado abaixo tem a função de encaminhar todas as requisições para o servidor Flask rodando localmente na porta 5000, e definir o nome de DNS que simulamos

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

### Ativar a configuração que definimos anteriormente e permite que o NGINX a utilize para servir as requisições. Passa o arquivo para o dir. sites-enabled do NGINX
sudo ln -s /etc/nginx/sites-available/myapp /etc/nginx/sites-enabled/

### Apos isso podemos resetar o serviço do NGINX com o comando ``sudo systemctl restart nginx`` e fazer o run da aplicação com ``python3 Application/app.py`` que ela já estará acessivel pelo nome de DNS que definimos


