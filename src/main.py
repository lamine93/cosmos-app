import os
from fastapi import FastAPI
from azure.cosmos import CosmosClient, PartitionKey, exceptions

ENDPOINT = os.environ["COSMOS_ENDPOINT"]
KEY      = os.environ["COSMOS_KEY"]
DB_NAME  = os.environ.get("COSMOS_DB", "appdb")
CT_NAME  = os.environ.get("COSMOS_CONTAINER", "items")

app = FastAPI()
client = CosmosClient(ENDPOINT, KEY)
db = client.create_database_if_not_exists(DB_NAME)
container = db.create_container_if_not_exists(id=CT_NAME, partition_key=PartitionKey(path="/pk"))

@app.get("/")
def root():
    return {"status": "ok"}

@app.post("/items")
def add_item(item: dict):
    # impose une partition key simple
    item.setdefault("pk", item.get("pk","default"))
    container.create_item(item)
    return {"inserted": True}

@app.get("/items")
def list_items():
    return list(container.read_all_items())
