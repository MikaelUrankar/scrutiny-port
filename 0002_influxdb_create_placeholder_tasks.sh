#!/bin/sh

# https://github.com/AnalogJ/scrutiny/blob/master/docs/TROUBLESHOOTING_INFLUXDB.md#create-placeholder-tasks

. 0000_influxdb_setup_environmental_variables

curl -sS -X POST ${INFLUXDB_HOSTNAME}/api/v2/tasks \
    -H "Content-Type: application/json" \
    -H "Authorization: Token ${INFLUXDB_ADMIN_TOKEN}" \
    --data-binary @- << EOF
{
  "orgID": "${INFLUXDB_ORG_ID}",
  "flux": "option task = {name: \"tsk-weekly-aggr\", every: 1y} \nyield now()"
}
EOF

curl -sS -X POST ${INFLUXDB_HOSTNAME}/api/v2/tasks \
    -H "Content-Type: application/json" \
    -H "Authorization: Token ${INFLUXDB_ADMIN_TOKEN}" \
    --data-binary @- << EOF
{
  "orgID": "${INFLUXDB_ORG_ID}",
  "flux": "option task = {name: \"tsk-monthly-aggr\", every: 1y} \nyield now()"
}
EOF

curl -sS -X POST ${INFLUXDB_HOSTNAME}/api/v2/tasks \
    -H "Content-Type: application/json" \
    -H "Authorization: Token ${INFLUXDB_ADMIN_TOKEN}" \
    --data-binary @- << EOF
{
  "orgID": "${INFLUXDB_ORG_ID}",
  "flux": "option task = {name: \"tsk-yearly-aggr\", every: 1y} \nyield now()"
}
EOF
