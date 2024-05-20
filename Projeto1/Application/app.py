from flask import Flask, render_template, request, redirect
from pymongo import MongoClient

app = Flask(__name__)

### conecta a aplicação ao mongoDB na porta 27017, "mongo" é o nome do serviço e 27017 é a porta configurada, definidos na docker-compose.yaml.
client = MongoClient("mongodb://mongo:27017/")
db = client.mydatabase
users_collection = db.users

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/add', methods=['GET', 'POST'])
def add():
    if request.method == 'POST':
        name = request.form['name']
        color = request.form['color']
        users_collection.insert_one({'name': name, 'color': color})
        return redirect('/display')
    return render_template('add.html')

@app.route('/display')
def display():
    users = users_collection.find()
    return render_template('display.html', users=users)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
### "debug=True" permite que erros do Python apareçam na página da webajudando a identificar os erros.
