from flask import render_template, redirect, request, session
from market.dbcon import mysql
from market import app
import MySQLdb.cursors


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

    if (request.method == 'POST' and 'name' in request.form and
            'barcode' in request.form and 'price' in request.form):
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


@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'GET':
        return render_template('login.html')

    if (request.method == 'POST' and
            'username' in request.form and 'password' in request.form):

        username = request.form['username']
        password = request.form['password']
        cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        sql = 'SELECT * FROM users WHERE username = %s AND password = %s'
        cur.execute(sql, [username, password])
        user = cur.fetchone()
        cur.close()

        if user:
            session['loggedin'] = True
            session['id'] = user['id']
            session['username'] = user['username']
            return redirect('/market')
        else:
            msg = 'Incorrect username or password'
            return render_template('login.html', msg=msg)


@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'GET':
        return render_template('register.html')

    if (request.method == 'POST' and 'username' in request.form and
            'password' in request.form and 'email' in request.form):
        username = request.form['username']
        password = request.form['password']
        confirm_password = request.form['confirmPassword']
        email = request.form['email']
        passwords_dont_coincide = (True if password != confirm_password
                                   else False)
        cur = mysql.connection.cursor()
        cur.execute('select * from users where username=%s', [username])
        usernameExists = cur.fetchone()
        cur.execute('SELECT * FROM  users WHERE email = %s', [email])
        emailExists = cur.fetchone()
        if passwords_dont_coincide:
            msg = "Passwords must be the same"
            return render_template('register.html', msg=msg)
        if usernameExists:
            msg = 'username is already used'
            return render_template('register.html', msg=msg)
        elif emailExists:
            msg = 'email is already used'
            return render_template('register.html', msg=msg)
        else:
            cur.execute('''INSERT INTO users(username, password, email) VALUES
            ( % s, % s, % s)''', [username, password, email])
            mysql.connection.commit()
            return redirect('/market')
