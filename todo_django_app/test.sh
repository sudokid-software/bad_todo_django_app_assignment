#!/usr/bin/env bash

# Create multiple
curl --request POST \
  --url http://127.0.0.1:8000/api/todo/ \
  --header 'content-type: application/json' \
  --data '[
    {
        "state": "todo",
  "due_date": "2018-01-01",
  "description": "test1"
    },
    {
        "state": "todo",
  "due_date": "2018-01-01",
  "description": "test2"
    },
    {
        "state": "in-progress",
  "due_date": "2018-01-01",
  "description": "test3"
    },
    {
        "state": "done",
  "due_date": "2018-01-01",
  "description": "test4"
    },
    {
        "state": "done",
  "due_date": "2018-01-02",
  "description": "test5"
    },
    {
        "state": "in-progress",
  "due_date": "2018-01-02",
  "description": "test6"
    },
    {
        "state": "todo",
  "due_date": "2018-01-02",
  "description": "test7"
    },
    {
        "state": "todo",
  "due_date": "2018-01-01",
  "description": "test8"
    }
]' | python -m json.tool

# Create single
curl --request POST \
  --url 'http://127.0.0.1:8000/api/todo/' \
  --header 'content-type: application/json' \
  --data '[{
	"state": "todo",
	"due_date": "2018-01-01",
	"description": "test"
}]' | python -m json.tool

# Get all
curl --request GET \
  --url 'http://127.0.0.1:8000/api/todo/' \
  --header 'content-type: application/json' | python -m json.tool

# Get single
curl --request GET \
  --url 'http://127.0.0.1:8000/api/todo/1/' \
  --header 'content-type: application/json' | python -m json.tool

# Get with filter state
curl --request GET \
  --url 'http://127.0.0.1:8000/api/todo/?state=done' \
  --header 'content-type: application/json' | python -m json.tool

# Get with filter due-date
curl --request GET \
  --url 'http://127.0.0.1:8000/api/todo/?due-date=2018-01-02' \
  --header 'content-type: application/json' | python -m json.tool

# Get with filter state and due-date
curl --request GET \
  --url 'http://127.0.0.1:8000/api/todo/?state=todo&due-date=2018-01-02' \
  --header 'content-type: application/json' | python -m json.tool

# Update single
curl --request PATCH \
  --url http://127.0.0.1:8000/api/todo/ \
  --header 'content-type: application/json' \
  --data '[{
	"id": 1,
	"state": "done"
}]' | python -m json.tool

# Update multiple
curl --request PATCH \
  --url 'http://127.0.0.1:8000/api/todo/' \
  --header 'content-type: application/json' \
  --data '[
	{
		"id": 1,
		"state": "done"
	},
	{
		"id": 2,
		"state": "done"
	}
]' | python -m json.tool

# Delete single
curl --request DELETE \
  --url 'http://127.0.0.1:8000/api/todo/' \
  --header 'content-type: application/json' \
  --data '[
    1
]' | python -m json.tool

# Delete multiple
curl --request DELETE \
  --url 'http://127.0.0.1:8000/api/todo/' \
  --header 'content-type: application/json' \
  --data '[
	2,3
]' | python -m json.tool
