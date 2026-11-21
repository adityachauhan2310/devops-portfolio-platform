import os

from fastapi import FastAPI

# Read the version from an "environment variable".
# If it's not set, use "0.1.0". The pipeline will set this automatically later.
APP_VERSION = os.getenv("APP_VERSION", "0.1.0")

# Create the app
app = FastAPI(title="DevOps Portfolio Platform")


# Endpoint 1: "are you alive?"
@app.get("/health")
def health():
    return {"status": "ok"}


# Endpoint 2: "which version are you?"
@app.get("/version")
def version():
    return {"version": APP_VERSION}
