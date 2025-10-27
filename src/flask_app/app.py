from flask import Flask

app = Flask(__name__)

# This is a simple Flask application
@app.route('/')
def hello():
    return 'Hello, world!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

# Additional route for health check
@app.route('/health')
def health_check():
    return 'OK', 200

"""
This Flask application serves a simple "Hello, world!" message at the root URL and provides a health check endpoint at /health.
"""