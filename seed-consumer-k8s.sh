#!/bin/bash

#
#  Copyright (c) 2024 Metaform Systems, Inc.
#
#  This program and the accompanying materials are made available under the
#  terms of the Apache License, Version 2.0 which is available at
#  https://www.apache.org/licenses/LICENSE-2.0
#
#  SPDX-License-Identifier: Apache-2.0
#
#  Contributors:
#       Metaform Systems, Inc. - initial API and implementation
#
#

## This script must be executed when running the dataspace from IntelliJ. Neglecting to do that will render the connectors
## inoperable!

## Seed management DATA to identityhubsl
API_KEY="c3VwZXItdXNlcg==.c3VwZXItc2VjcmV0LWtleQo="

# add consumer participant
echo
echo
echo "Create consumer participant context in IdentityHub"
CONSUMER_CONTROLPLANE_SERVICE_URL="http://consumer2-controlplane:9082"
CONSUMER_IDENTITYHUB_URL="http://consumer2-identityhub:7082"
DATA_CONSUMER=$(jq -n --arg url "$CONSUMER_CONTROLPLANE_SERVICE_URL" --arg ihurl "$CONSUMER_IDENTITYHUB_URL" '{
           "roles":[],
           "serviceEndpoints":[
             {
                "type": "CredentialService",
                "serviceEndpoint": "\($ihurl)/api/credentials/v1/participants/ZGlkOndlYjpjb25zdW1lcjItaWRlbnRpdHlodWIlM0E3MDgzOmNvbnN1bWVyMg==",
                "id": "consumer-credentialservice-1"
             },
             {
                "type": "ProtocolEndpoint",
                "serviceEndpoint": "\($url)/api/dsp",
                "id": "consumer-dsp"
             }
           ],
           "active": true,
           "participantId": "did:web:consumer2-identityhub%3A7083:consumer2",
           "did": "did:web:consumer2-identityhub%3A7083:consumer2",
           "key":{
               "keyId": "did:web:consumer2-identityhub%3A7083:consumer2#key-1",
               "privateKeyAlias": "did:web:consumer2-identityhub%3A7083:consumer2#key-1",
               "keyGeneratorParams":{
                  "algorithm": "EC"
               }
           }
       }')

curl --location "http://127.0.0.1/consumer/cs/api/identity/v1alpha/participants/" \
--header 'Content-Type: application/json' \
--header "x-api-key: $API_KEY" \
--data "$DATA_CONSUMER"