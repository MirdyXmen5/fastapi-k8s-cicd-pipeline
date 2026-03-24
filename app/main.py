from fastapi import FastAPI

app = FastAPI()

@get("/")
def read_root():
    return {"status": "ok", "message": "Hello from EKS cluster!"}