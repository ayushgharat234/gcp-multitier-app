#!/bin/bash

apt-get update
apt-get install -y python3-pip
pip3 install flask

cat <<EOF > /opt/app.py
from flask import Flask
app = Flask(__name__)

@app.route('/')
def home():
    return "Hello from the App Tier - ${hostname}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
EOF

nohup python3 /opt/app.py > /opt/app.log 2>&1 & 