from flask import Flask
import socket

app = Flask(__name__)

@app.route("/")
def hello():
    str = socket.gethostbyname(socket.gethostname())
    return "<H1>Hello Beautiful World! My IP address is " + str + "</H1>\n"

if __name__ == "__main__":
    app.run(host="0.0.0.0")

