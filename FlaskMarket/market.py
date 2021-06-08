from flask import Flask, render_template, redirect, request
from flask_mysqldb import MySQL
import MySQLdb


app = Flask(__name__)

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'password123'
app.config['MYSQL_DB'] = 'market'

mysql = MySQL(app)


@app.route('/')
def home_page():
    return render_template('home.html')


@app.route('/market')
def market_page():
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    sql = 'SELECT * FROM items'
    cur.execute(sql)
    items = cur.fetchall()
    cur.close()
    return render_template('market.html', items=items)


@app.route('/market/add_product', methods=['GET', 'POST'])
def new_product():
    if request.method == 'GET':
        return render_template('addproduct.html')

    if request.method == 'POST':
        name = request.form['name']
        barcode = request.form['barcode']
        price = request.form['price']
        description = request.form['description']

        cur = mysql.connection.cursor()
        sql = '''INSERT INTO items(name, barcode, price, description) 
        VALUES (%s, %s, %s, %s)'''
        cur.execute(sql, (name, barcode, price, description))
        mysql.connection.commit()
        cur.close()

        return redirect('/market')
