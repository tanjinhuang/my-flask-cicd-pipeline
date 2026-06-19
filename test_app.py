import pytest
from app import app


@pytest.fixture
def client():
    app.config["TESTING"] = True # configure Flask into a special testing mode
    with app.test_client() as client: # client is a fake test browser that simulates requests to the application
        yield client # use 'yield' to provide the client to the test functions


def test_home(client):
    response = client.get("/") # the fake test browser's root page
    assert response.status_code == 200 # check html response code
    data = response.get_json()
    assert data["message"] == "Welcome to the Flask CI/CD Pipeline API. This line has been modified to test the CI/CD pipeline function in GitHub Action." 


def test_health(client):
    response = client.get("/health")
    assert response.status_code == 200 # check html response code
    data = response.get_json()
    assert data["status"] == "healthy"