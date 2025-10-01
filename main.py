import os
from fastapi import FastAPI

app = FastAPI(title="Deployment Observability API")

@app.get("/")
async def root():
    return {
        "message": "Deployment Observability API is running",
        "space": "ga2-20c8b0",
        "status": "healthy"
    }

@app.get("/health")
async def health():
    return {"status": "ok"}

@app.get("/info")
async def info():
    return {
        "app_port": os.environ.get("APP_PORT", "7069"),
        "token_present": "GA2_TOKEN_7B51" in os.environ
    }
