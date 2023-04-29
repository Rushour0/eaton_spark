from flask import Flask, request
from flask_cors import CORS
import googlemaps
import os
from dotenv import load_dotenv
load_dotenv()

api_key = os.getenv('GCP-API-KEY')
gmaps = googlemaps.Client(key=api_key)

# Geocoding an address
app = Flask(__name__)
CORS(app)


@app.route('/places_nearby', methods=['POST'])
def places_nearby():
    post_json = request.get_json()

    return gmaps.places_nearby(
        location=post_json['location'],
        radius=post_json['radius'],
        keyword=post_json['keyword']
    )

@app.route('/autocomplete', methods=['POST'])
def autocomplete():
    args = request.args
    return gmaps.places_autocomplete(args.get('input'))

@app.route('/autocomplete_query', methods=['POST'])
def autocomplete_query():
    args = request.args
    
    return gmaps.places_autocomplete_query( args.get('query'))

app.run(host='0.0.0.0', port=81)
