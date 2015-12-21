#!/bin/bash

# Sanity check
if [ "$ASPACE_API_URL" = "" ]; then
    echo "Enter the URL to the AchivesSpace REST API (e.g. http://localhost:8089) "
    read -p "URL: " ASPACE_API_URL
    export ASPACE_API_URL
fi
if [ "$ASPACE_API_TOKEN" = "" ]; then
    echo "Enter the ArchivesSpace username and password to authenticate and get token:"
    read -p "Username: " ASPACE_USERNAME
    read -s -p "Password: " ASPACE_PASSWORD
fi

echo "Accessing ArchivesSpace via $ASPACE_API_URL"

# Login
REPSONSE=$(curl -Fpassword=$ASPACE_PASSWORD $ASPACE_API_URL/users/$ASPACE_USERNAME/login)
ASPACE_API_TOKEN=$(echo $RESPONSE | jq -r '.session')
if [ "$ASPACE_API_TOKEN" = "" ] && [ "$SPACE_API_TOKEN" != "null" ]; then
    echo "Bad response "$RESPONSE
    echo "Login failed."
else
    echo 'Running the following export command--'
    echo ''
    echo 'export ASPACE_API_TOKEN='$ASPACE_API_TOKEN
    echo ''
    echo 'Example curl command usage'
    echo '   curl -H "X-ArchivesSpace-Session: $ASPACE_API_TOKEN" '$ASPACE_API_URL
    echo ""
    export ASPACE_API_TOKEN
fi
