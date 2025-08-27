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

## Seed application DATA to both connectors
echo
echo
echo "Seed Issuer for consumer2"

## Seed participant data to the issuer service
newman run \
  --folder "Seed Issuer SQL" \
  --env-var "ISSUER_ADMIN_URL=http://127.0.0.1/issuer/ad" \
  --env-var "CONSUMER_ID=did:web:consumer2-identityhub%3A7083:consumer2" \
  --env-var "CONSUMER_NAME=MVD Consumer2 Participant" \
  ./deployment/postman/MVD.postman_collection_consumer2.json