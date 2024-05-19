# syntax=docker/dockerfile:1
### imagem oficial do pyhton 3.10.12 (versão usada na VM ubuntu) no formato leve, "puxada" do DockerHub
FROM python:3.10.12-slim
### Diretorio onde os arquivos da aplicação vão estar localizadas, dentro do container
WORKDIR /app
### Passar os arquivos da aplicação para dentro do diretorio de trabalho
COPY requirements.txt .
RUN pip install -r requirements.txt
### COPY [directory_where_dockerfile_is] [inside_word_directory] -> essa é a sintaxe do comando copy. Aqui passamos todos os arquivos que a aplicação encessita para funcionar para dentro do workdirectory do container
COPY app.py /app/
COPY templates/ /app/templates/
COPY static/ /app/static/
### expor a aplicação a porta 5000 
EXPOSE 5000
### Definir uma variavel de ambiente para o container, no caso o FLASK_APP é o arquivo qeu executa a aplicação (app.py)
ENV FLASK_APP=app.py
### o comando abaixo será executado apos o container iniciar, "ligando" a aplicação flask que criamos. O --host ensure the server accepts requests from all hosts.
CMD ["flask", "run", "--host", "0.0.0.0"]
