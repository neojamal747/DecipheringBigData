import os
import requests
import json
import sqlite3
from requests.exceptions import HTTPError

# API Key 
API_KEY = os.getenv('OPENWEATHERMAP_API_KEY')
BASE_URL = "https://api.openweathermap.org/data/2.5/weather"

# Fetch weather data securely
def fetch_weather(city_name):
    try:
        params = {
            'q': city_name,
            'appid': API_KEY,
            'units': 'metric'
        }
        response = requests.get(BASE_URL, params=params, timeout=10)
        response.raise_for_status()  # Errors HTTP

        # PValidate JSON response
        data = response.json()
        if 'main' in data and 'temp' in data['main']:
            return data
        else:
            raise ValueError("Invalid response structure")
    except HTTPError as http_err:
        print(f"HTTP error occurred: {http_err}")
    except Exception as err:
        print(f"Other error occurred: {err}")

city = "London"
weather_data = fetch_weather(city)
if weather_data:
    print(json.dumps(weather_data, indent=4))

def store_weather_data(data):
    try:
        conn = sqlite3.connect('weather_data.db')
        cursor = conn.cursor()

        # Create table 
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS weather (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                city TEXT NOT NULL,
                temperature REAL NOT NULL,
                description TEXT NOT NULL
            )
        ''')

        # Insert data into the table
        cursor.execute('''
            INSERT INTO weather (city, temperature, description)
            VALUES (?, ?, ?)
        ''', (data['name'], data['main']['temp'], data['weather'][0]['description']))

        conn.commit()
    except sqlite3.Error as e:
        print(f"SQLite error: {e}")
    finally:
        conn.close()

if weather_data:
    store_weather_data(weather_data)