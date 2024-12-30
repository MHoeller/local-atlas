db.getSiblingDB('myplaces').getCollection('restaurants').createSearchIndex({"mappings": {  "dynamic": false,  "fields": {    "name": {      "type": "string",      "analyzer": "lucene.standard",    }  }}
});
