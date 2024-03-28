#!/bin/sh

# https://github.com/AnalogJ/scrutiny/blob/master/docs/TROUBLESHOOTING_INFLUXDB.md#create-placeholder-buckets

. 0000_influxdb_setup_environmental_variables

curl -sS -X POST ${INFLUXDB_HOSTNAME}/api/v2/buckets \
-H "Content-Type: application/json" \
-H "Authorization: Token ${INFLUXDB_ADMIN_TOKEN}" \
--data-binary @- << EOF
{
"name": "${INFLUXDB_SCRUTINY_BUCKET_BASENAME}",
"orgID": "${INFLUXDB_ORG_ID}",
"retentionRules": []
}
EOF

curl -sS -X POST ${INFLUXDB_HOSTNAME}/api/v2/buckets \
-H "Content-Type: application/json" \
-H "Authorization: Token ${INFLUXDB_ADMIN_TOKEN}" \
--data-binary @- << EOF
{
"name": "${INFLUXDB_SCRUTINY_BUCKET_BASENAME}_weekly",
"orgID": "${INFLUXDB_ORG_ID}",
"retentionRules": []
}
EOF

curl -sS -X POST ${INFLUXDB_HOSTNAME}/api/v2/buckets \
-H "Content-Type: application/json" \
-H "Authorization: Token ${INFLUXDB_ADMIN_TOKEN}" \
--data-binary @- << EOF
{
"name": "${INFLUXDB_SCRUTINY_BUCKET_BASENAME}_monthly",
"orgID": "${INFLUXDB_ORG_ID}",
"retentionRules": []
}
EOF

curl -sS -X POST ${INFLUXDB_HOSTNAME}/api/v2/buckets \
-H "Content-Type: application/json" \
-H "Authorization: Token ${INFLUXDB_ADMIN_TOKEN}" \
--data-binary @- << EOF
{
"name": "${INFLUXDB_SCRUTINY_BUCKET_BASENAME}_yearly",
"orgID": "${INFLUXDB_ORG_ID}",
"retentionRules": []
}
EOF
