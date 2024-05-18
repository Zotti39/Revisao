# Projeto1

Abaixo deixarei a File Tree inicial da aplicação planejada

Application/
├── static/
│   └── styles.css
├── templates/
│   └── index.html
├── app.py
└── requirements.txt

## 1 Implantação com servidor Flask

Para preparar o ambiente para suportar a aplicação com flask, rodei o script `startScript.sh`, que é usado para instalar as dependencias do Python e Flask

Para iniciar a aplicação localmente utilizei o seguinte comando no terminal:

        python3 app.py

Agora ao acessar a url `http://localhost:5000` veremos a aplicação funcionando. Vale ressaltar que essa aplicação está exposta apenas a rede local, ou seja, só pode ser acessada por dispositivos que estejam utilizando a mesma rede wi-fi, seu celular por exemplo.

## EXTRA Simulação de nome de DNS com /etc/hosts
### Feito sem utilizar o nginx

Dentro da VM é possivel simular um dominio de DNS para a aplicação, para isso, após rodar o comando `python3 app.py` aparecerá como output o ip em que a aplicação está rodando. Dentro do arquivo /etc/hosts (Deve ser acessado com permissoes de superusuario) passamos a seguinte linha ao final do arquivo:

        192.168.1.6 myapp.com

Considerando que 192.168.1.6 é o IP em que a aplicação está rodando e myapp.com o dominio que queremos utilizar. Após isso a aplicação podera ser acessada pelo navegador utilizando `myapp.com:5000` na barra de pesquisa.

## 2. Utilizando o nginx como ProxyReverso

O script `nginxScript.sh` criará um arquivo que será utilizado para definir as configuraçoes do servidor. Ele tambem fará a definição do nome de dominio da aplicação, que no caso vai ser `minhaaplicacao.com`. 

Para poder utilizar o nome de dominio `minhaaplicacao.com` devemos adicioanr isso ao /etc/hosts para simular esse nome de dominio, similar ao que foi descrito no passo EXTRA anterior

Após rodar o script e configurar o "DNS" aplique os seguintes comandos no terminal:

Para testar a validade da configuração do NGINX:

        sudo nginx -t

Reinicia o servidor nginx

        sudo systemctl restart nginx

Iniciar a aplicação 

        python3 Application/app.py

Agora, ao acessar `minhaaplicacao.com` no navegador, você deve ver a aplicação rodando com o NGINX como proxy reverso para o Flask.