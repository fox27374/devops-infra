#!/bin/bash

JSONPATH=/opt/setup/guacamole
POSTGREST_SERVICE=$(kubectl get svc postgrest -n guacamole -o jsonpath='{.spec.clusterIP}')
POSTGREST_PORT=$(kubectl get svc postgrest -n guacamole -o jsonpath='{.spec.ports[0].port}')
POSTGREST_URL=http://$POSTGREST_SERVICE:$POSTGREST_PORT

# Delete all non-default configuration
curl $POSTGREST_URL/guacamole_connection_parameter?connection_id=gte.1 -X DELETE
curl $POSTGREST_URL/guacamole_connection_permission?entity_id=gt.1 -X DELETE
curl $POSTGREST_URL/guacamole_connection?connection_id=gte.1 -X DELETE
curl $POSTGREST_URL/guacamole_connection_group_permission?entity_id=gt.1 -X DELETE
curl $POSTGREST_URL/guacamole_connection_group?connection_group_id=gte.1 -X DELETE
curl $POSTGREST_URL/guacamole_user_group?entity_id=gte.1 -X DELETE
curl $POSTGREST_URL/guacamole_user?entity_id=gt.1 -X DELETE
curl $POSTGREST_URL/guacamole_entity?entity_id=gt.1 -X DELETE

# Apply JSON config files
curl $POSTGREST_URL/guacamole_entity -H "Content-Type: application/json" -X POST -d @$JSONPATH/guac_entity.json
curl $POSTGREST_URL/guacamole_user_group -H "Content-Type: application/json" -X POST -d @$JSONPATH/guac_user_group.json
curl $POSTGREST_URL/guacamole_user -H "Content-Type: application/json" -X POST -d @$JSONPATH/guac_user.json
curl $POSTGREST_URL/guacamole_connection_group -H "Content-Type: application/json" -X POST -d @$JSONPATH/guac_connection_group.json
curl $POSTGREST_URL/guacamole_connection_group_permission -H "Content-Type: application/json" -X POST -d @$JSONPATH/guac_connection_group_permission.json
curl $POSTGREST_URL/guacamole_connection -H "Content-Type: application/json" -X POST -d @$JSONPATH/guac_connection.json
curl $POSTGREST_URL/guacamole_connection_parameter -H "Content-Type: application/json" -X POST -d @$JSONPATH/guac_connection_parameter.json
curl $POSTGREST_URL/guacamole_connection_permission -H "Content-Type: application/json" -X POST -d @$JSONPATH/guac_connection_permission.json