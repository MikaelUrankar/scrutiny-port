#!/bin/sh

# https://github.com/AnalogJ/scrutiny/blob/master/docs/TROUBLESHOOTING_INFLUXDB.md#create-influxdb-api-token

. 0000_influxdb_setup_environmental_variables

# replace these values with placeholder bucket and task ids from your InfluxDB installation. 
export INFLUXDB_SCRUTINY_BASE_BUCKET_ID=1e0709xxxx
export INFLUXDB_SCRUTINY_WEEKLY_BUCKET_ID=1af03dexxxxx
export INFLUXDB_SCRUTINY_MONTHLY_BUCKET_ID=b3c59c7xxxxx
export INFLUXDB_SCRUTINY_YEARLY_BUCKET_ID=f381d8cxxxxx

export INFLUXDB_SCRUTINY_WEEKLY_TASK_ID=09a64ecxxxxx
export INFLUXDB_SCRUTINY_MONTHLY_TASK_ID=09a64xxxxx
export INFLUXDB_SCRUTINY_YEARLY_TASK_ID=09a64ecxxxxx


curl -sS -X POST ${INFLUXDB_HOSTNAME}/api/v2/authorizations \
    -H "Content-Type: application/json" \
    -H "Authorization: Token ${INFLUXDB_ADMIN_TOKEN}" \
    --data-binary @- << EOF
{
  "description": "scrutiny - restricted scope token",
  "orgID": "${INFLUXDB_ORG_ID}",
  "permissions": [
        {
            "action": "read",
            "resource": {
                "type": "orgs"
            }
        },
        {
            "action": "read",
            "resource": {
                "type": "tasks"
            }
        },
        {
            "action": "write",
            "resource": {
                "type": "tasks",
                "id": "${INFLUXDB_SCRUTINY_WEEKLY_TASK_ID}",
                "orgID": "${INFLUXDB_ORG_ID}"
            }
        },
        {
            "action": "write",
            "resource": {
                "type": "tasks",
                "id": "${INFLUXDB_SCRUTINY_MONTHLY_TASK_ID}",
                "orgID": "${INFLUXDB_ORG_ID}"
            }
        },
        {
            "action": "write",
            "resource": {
                "type": "tasks",
                "id": "${INFLUXDB_SCRUTINY_YEARLY_TASK_ID}",
                "orgID": "${INFLUXDB_ORG_ID}"
            }
        },
        {
            "action": "read",
            "resource": {
                "type": "buckets",
                "id": "${INFLUXDB_SCRUTINY_BASE_BUCKET_ID}",
                "orgID": "${INFLUXDB_ORG_ID}"
            }
       },
        {
            "action": "write",
            "resource": {
                "type": "buckets",
                "id": "${INFLUXDB_SCRUTINY_BASE_BUCKET_ID}",
                "orgID": "${INFLUXDB_ORG_ID}"
            }
       },
        {
            "action": "read",
            "resource": {
                "type": "buckets",
                "id": "${INFLUXDB_SCRUTINY_WEEKLY_BUCKET_ID}",
                "orgID": "${INFLUXDB_ORG_ID}"
            }
       },
        {
            "action": "write",
            "resource": {
                "type": "buckets",
                "id": "${INFLUXDB_SCRUTINY_WEEKLY_BUCKET_ID}",
                "orgID": "${INFLUXDB_ORG_ID}"
            }
       },
        {
            "action": "read",
            "resource": {
                "type": "buckets",
                "id": "${INFLUXDB_SCRUTINY_MONTHLY_BUCKET_ID}",
                "orgID": "${INFLUXDB_ORG_ID}"
            }
       },
        {
            "action": "write",
            "resource": {
                "type": "buckets",
                "id": "${INFLUXDB_SCRUTINY_MONTHLY_BUCKET_ID}",
                "orgID": "${INFLUXDB_ORG_ID}"
            }
       },
        {
            "action": "read",
            "resource": {
                "type": "buckets",
                "id": "${INFLUXDB_SCRUTINY_YEARLY_BUCKET_ID}",
                "orgID": "${INFLUXDB_ORG_ID}"
            }
       },
        {
            "action": "write",
            "resource": {
                "type": "buckets",
                "id": "${INFLUXDB_SCRUTINY_YEARLY_BUCKET_ID}",
                "orgID": "${INFLUXDB_ORG_ID}"
            }
       }
  ]
}
EOF

echo "You must copy the token field from the JSON response, and save it in your scrutiny.yaml config file"
