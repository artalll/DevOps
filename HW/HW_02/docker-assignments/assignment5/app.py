from flask import Flask, request
import logging
import os
app = Flask(__name__)
log_dir = "/logs"
os.makedirs(log_dir, exist_ok=True)
log_file = os.path.join(log_dir, "app.log")
logging.basicConfig(
    filename=log_file,
    level=logging.INFO,
    format="%(asctime)s - %(message)s")
logging.info("Flask app started")kube
@app.before_request
def log_request_info():
    logging.info(f"Request from {request.remote_addr} - {request.method} {request.path}")
@app.route("/")
def hello():
    return "Hello from Flask with logging!"
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

