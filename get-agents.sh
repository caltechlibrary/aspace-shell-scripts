#!/bin/bash

# Sanity check
if [ "$ASPACE_API_URL" = "" ] || [ "$ASPACE_API_TOKEN" = "" ]; then
    echo "You need to setup your environment variables for accessing your ArchivesSpace deployment"
    exit 1
fi

echo "Accessing ArchivesSpace via $ASPACE_API_URL"
function getAgents {
    AGENT_TYPE=$1
    echo "Setting up data directory for $AGENT_TYPE"
    mkdir -p data-export/agents/$AGENT_TYPE
    # Get a list of all agents ids
    echo "Getting ids for /agents/$AGENT_TYPE"
    curl -H "X-ArchivesSpace-Session: $ASPACE_API_TOKEN" $ASPACE_API_URL/agents/$AGENT_TYPE?all_ids=true | sed -E "s/\[//;s/,/ /g;s/]//" | tr " " "\n" > data-export/$AGENT_TYPE-ids.txt

    # Now for each agent id in data-export/agents-*-ids.txt get a full record.
    echo "Reading /agent/$AGENT_TYPE ids and fetch their JSON records "
    cat data-export/$AGENT_TYPE-ids.txt | while read AGENT_ID; do
        if [ "$AGENT_ID" != "" ]; then
            curl -H "X-ArchivesSpace-Session: $ASPACE_API_TOKEN" $ASPACE_API_URL/agents/$AGENT_TYPE/$AGENT_ID > data-export/agents/$AGENT_TYPE/$AGENT_ID.json
        fi
    done
    echo "Completed $AGENT_TYPE"
}

getAgents people
getAgents corporate_entities
getAgents families
getAgents software
echo ""
echo "Done."
