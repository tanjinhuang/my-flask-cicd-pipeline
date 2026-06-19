from flask import Flask, jsonify

app = Flask(__name__)


@app.route("/")
def home():
    return jsonify({"message": "Welcome to the Flask CI/CD Pipeline API. This line has been modified to test the CI/CD pipeline function in GitHub Action."})


@app.route("/health")
def health():
    return jsonify({"status": "healthy"})


if __name__ == "__main__":
    # app.run(debug=True)  # Enable debug mode for development
    app.run(host="0.0.0.0", port=5000)