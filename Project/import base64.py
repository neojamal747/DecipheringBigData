import base64
import requests

# API credentials
client_id = "2e748f3889434eab8c0f8970d002314f"
client_secret = "sDmZnZH4nhTYWYbP7C1pZI1IR8S25FkZlced_1BDwqA5cpXon6YvpIHGw9H11GbN"

# Endpoint URL for authentication
auth_url = "https://kenvue.api.us.nexthink.cloud/api/v1/token"

def test_api_authentication():
    # Encode credentials in Base64 for Basic Authentication
    auth_header_value = base64.b64encode(f"{client_id}:{client_secret}".encode()).decode()

    # Set up headers
    headers = {
        "Authorization": f"Basic {auth_header_value}",
        "Content-Type": "application/json",
    }

    try:
        # Make the POST request to the token endpoint
        response = requests.post(auth_url, headers=headers)
        response.raise_for_status()  # Raise an error if the response status code is not 200

        # Parse the JSON response
        token_response = response.json()

        # Print success message with the token details
        print("API Authentication Successful!")
        print(f"Access Token: {token_response.get('access_token')}")
        print(f"Token Expiry: {token_response.get('expires_in')} seconds")
    except requests.exceptions.RequestException as e:
        # Handle errors (e.g., invalid credentials, server issues)
        print("Error during API Authentication.")
        print(e)

if __name__ == "__main__":
    test_api_authentication()