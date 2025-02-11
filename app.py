from flask import Flask, jsonify

# Initialize the Flask app
app = Flask(__name__)

# Define the route for leaderboard data
@app.route('/leaderboard')
def leaderboard():
    # Example leaderboard data (this would normally come from a database or API)
    return jsonify({"leaderboard": ["Player1", "Player2", "Player3"]})

# Run the app when this script is executed
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)  # Run the app on localhost:5000