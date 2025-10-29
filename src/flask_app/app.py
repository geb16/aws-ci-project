from flask import Flask

app = Flask(__name__)

# This is a simple Flask application
@app.route('/')
def hello():
    return 'Hello, world! This is a Simple Flask app running inside ec2 instance. \n AWS is awesome!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

# Additional route for health check
@app.route('/health')
def health_check():
    return 'OK', 200

