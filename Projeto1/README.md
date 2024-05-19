# Projeto1

Abaixo deixarei a File Tree atualizada da aplicação em uso, que por hora será um website basico, já que o objetivo é apenas fazer o deployment

```bash
Application/
├── static/
│   └── styles.css
├── templates/
│   └── index.html
├── app.py
├── requirements.txt
├── DockerFile                          
├── docker-compose.yaml
└── nginx.conf
```

## 1. Implantação com servidor Flask

Para preparar o ambiente para suportar a aplicação com flask, rodei o script `startScript.sh`, que é usado para instalar as dependencias do Python e Flask

Para iniciar a aplicação localmente utilizei o seguinte comando no terminal:

        python3 app.py

Agora ao acessar a url `http://localhost:5000` veremos a aplicação funcionando. Vale ressaltar que essa aplicação está exposta apenas a rede local, ou seja, só pode ser acessada por dispositivos que estejam utilizando a mesma rede wi-fi, seu celular por exemplo.

## EXTRA Simulação de nome de DNS com /etc/hosts
### Feito sem utilizar o nginx

Dentro da VM é possivel simular um dominio de DNS para a aplicação, para isso, após rodar o comando `python3 app.py` aparecerá como output o ip em que a aplicação está rodando. Dentro do arquivo ``/etc/hosts`` (Deve ser acessado com permissoes de superusuario) passamos a seguinte linha ao final do arquivo:

        192.168.1.6 myapp.com

Considerando que 192.168.1.6 é o IP em que a aplicação está rodando e myapp.com o dominio que queremos utilizar. Após isso a aplicação podera ser acessada pelo navegador utilizando `myapp.com:5000` na barra de pesquisa. Ressaltando que esse nome de dominio so vale para a maquina em que se está executando a aplicação, pois o arquivo ``/etc/hosts`` será consultado antes do navegador procurar pela url em servidores DNS externos.

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

## 3. Containerizando a aplicação com Docker

OBS: para essa parte não foi utilizado nenhum simulador de nome de dominio

O arquivo ``Dockerfile`` dentro do repositorio, fará o empacotamento da aplicação Flask, transformando ela em uma imagem de um container.

O arquivo ``docker-compose.yaml`` facilita o processo de implementação da aplicação, subindo os dois containers necessarios (do nginx e da app) de uma só vez, provendo tambem facil reprodudutibilidade e portabilidade do sistema.

O arquivo ``nginx.conf`` define como o NGINX deve lidar com as requisições HTTP recebidas e como essas requisições devem ser encaminhadas para o serviço Flask rodando em outro contêiner. 

Para iniciar esse sistema devemos primerio para o nginx que esta funcionando na maquina, pois o sistema containerizado necessita das mesmas portas para funcionar:

                systemctl stop nginx
        
Agora podemos passar o comando:

                docker-compose -f Application/docker-compose.yaml up -d

Agora ao acessar ``http://localhost`` no navegador, veremos a aplicação rodando

### Como o nginx faz o redirecionamento de trafego
1. Um cliente acessa ``http://localhost`` no navegador.
2. A requisição chega ao contêiner NGINX, que está mapeando a porta 80 do host para a porta 80 do contêiner.
3. Dentro do contêiner NGINX, a configuração proxy_pass ``http://web:5000`` redireciona a requisição para o serviço web na porta 5000.
4. O Docker Compose gerencia a rede interna, permitindo que web seja resolvido para o IP correto do contêiner que executa o serviço Flask.
5. O serviço Flask processa a requisição e retorna a resposta ao NGINX.
6. O NGINX então envia o site com a aplicação de volta ao cliente.