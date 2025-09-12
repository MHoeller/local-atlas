# Getting Started with MongoDB Atlas Local Search Experience Using Docker

## Running the Local Environment

### Using Docker Run

To start the local environment with MongoDB core database and Atlas Search, execute the following command:

```bash
docker run -p 27017:27017 mongodb/mongodb-atlas-local
```

Once the container is running, you can connect to the database using `mongosh` with this command:

```bash
mongosh "mongodb://localhost/?directConnection=true"
```

---

### Using Docker Compose

The environment setup is defined in the `docker-compose.yml` file. To start the local environment, run:  

```bash
docker compose up
```

This initiates the following processes:  

1. **Environment Initialization**:  
   A local environment is created with the core database and Atlas Search functionality.  

2. **Execution of Initialization Scripts**:  
   Initialization scripts from the `./init` directory are executed in alphanumeric order. This directory is mounted into the container at `/docker-entrypoint-initdb.d`.  

#### Example Initialization Workflow:  

- **[00-import-from-export.sh](init/00-import-from-export.sh)**:  
  Imports data from a MongoDB export (a JSON file) using `mongoimport`.  

- **[01-import-explicit-inserts.js](init/01-import-explicit-inserts.js)**:  
  Demonstrates an alternative approach for seeding data using explicit `insertMany` operations.  

- **[02-create-search-index.js](init/02-create-search-index.js)**:  
  Creates a search index for the `restaurants` collection, enabling advanced query capabilities.  

---

## Testing the Search Index

You can verify that the search index works by running the following aggregation query:

```javascript
db.getSiblingDB('myplaces')
  .getCollection('restaurants')
  .aggregate([
    {
      "$search": {
        "index": "default",
        "text": {
          "query": "Food",
          "path": "name",
          "fuzzy": {
            "maxEdits": 2
          }
        }
      }
    },
    {
      "$limit": 3
    },
    {
      "$project": {
        "_id": 0,
        "name": 1,
        "cuisine": 1
      }
    }
  ]);
```

This query performs a fuzzy search on the `name` field of the `restaurants` collection, looking for entries similar to "Food." It returns the top three results, displaying only the `name` and `cuisine` fields.

---

### Notes  

- Ensure that all required initialization scripts and data files are present in the `./init` directory before running the environment.  
- The provided scripts are examples that you can modify to suit your specific requirements.  

