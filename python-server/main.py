from flask import Flask
from flask_restful import reqparse
import googlemaps
from datetime import datetime
import os
from dotenv import load_dotenv
load_dotenv()

api_key = os.getenv('GCP-API-KEY')
gmaps = googlemaps.Client(key=api_key)

# Geocoding an address
app = Flask(__name__)

print(
    gmaps.geocode('MIT World Peace University, Pune, Maharashtra 411038')
)


@app.route('/places')
def index():

    return 'Hello from Flask!'


app.run(host='0.0.0.0', port=81)
