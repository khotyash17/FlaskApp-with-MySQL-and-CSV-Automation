from flask import Flask, render_template, request
import mysql.connector
import traceback
import sys

app = Flask(__name__)

# Database configuration
db_config = {
    'host': 'db',   # docker-compose service name for MySQL
    'user': 'root',
    'password': 'password',
    'database': 'studentsdb'
}

@app.route('/', methods=['GET', 'POST'])
def register():
    try:
        if request.method == 'POST':
            name = request.form['name']
            email = request.form['email']

            conn = mysql.connector.connect(**db_config)
            cursor = conn.cursor()

            #check if it alredy exists
            cursor.execute(
                 "SELECT * FROM students WHERE email=%s", (email,)
            )
            existing = cursor.fetchone()

            if existing:
                     return ' User already exist'


            cursor.execute(
                'INSERT INTO students (name, email) VALUES (%s, %s)',
                (name, email)
            )
            conn.commit()
            cursor.close()
            conn.close()

            return '✅ Student Registered Successfully!'

        return render_template('register.html')

    except Exception as e:
        # Log full traceback in container logs
        traceback.print_exc(file=sys.stdout)
        # Show full traceback in browser
        return f"<pre>{traceback.format_exc()}</pre>", 500


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
