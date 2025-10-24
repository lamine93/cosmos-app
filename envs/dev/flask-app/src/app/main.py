import os

from azure.cosmos import CosmosClient, PartitionKey, exceptions
from fastapi import FastAPI, HTTPException, Query
from pydantic import BaseModel
from typing import Any, Dict

class ItemUpdate(BaseModel):
    data: Dict[str, Any]

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

@app.get("/items/{item_id}")
def get_item(item_id: str, pk: str = Query("default", description="Partition key")):
    try:
        doc = container.read_item(item=item_id, partition_key=pk)
        return doc
    except exceptions.CosmosResourceNotFoundError:
        raise HTTPException(status_code=404, detail=f"Item {item_id} not found in pk='pk'")
    

@app.put("/items/{item_id}")
def update_item(item_id: str, payload: ItemUpdate, pk: str = Query("default")):
    try:
        doc = container.read_item(item=item_id, partition_key=pk)
        doc.update(payload.data) # mets à jour les champs
        saved = container.replace_item(item=doc, body=doc)
        return saved
    except exceptions.CosmosResourceNotFoundError:
        raise HTTPException(status_code=404, detail=f"Item {item_id} not found in pk='{pk}'")

@app.delete("/items/{item_id}")
def delete_item(item_id: str, pk: str = Query("default")):
    try:
        container.delete_item(item=item_id, partition_key=pk)
        return {"deleted": True, "id": item_id, "pk": pk}
    except exceptions.CosmosResourceNotFoundError:
        raise HTTPException(status_code=404, detail=f"Item {item_id} not found in pk='{pk}'")