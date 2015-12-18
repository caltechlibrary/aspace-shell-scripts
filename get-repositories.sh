#!/bin/bash

# Sanity check
if [ "$ASPACE_API_URL" = "" ] || [ "$ASPACE_API_TOKEN" = "" ]; then
    echo "You need to setup your environment variables for accessing your ArchivesSpace deployment"
    exit 1
fi
echo "Accessing ArchivesSpace via $ASPACE_API_URL"

function getRepository {
    echo "Setting up data directory for repositories"
    mkdir -p data-export/repositories
    # Get a list of all agents ids
    echo "Getting ids for /agents/$AGENT_TYPE"
    curl -H "X-ArchivesSpace-Session: $ASPACE_API_TOKEN" $ASPACE_API_URL/repositories |  jq -r ".[].uri" | cut -d / -f 3 > data-export/repository-ids.txt

    # Now for each agent id in data-export/agents-*-ids.txt get a full record.
    echo "Reading repository-paths and fetch their JSON records "
    cat data-export/repository-ids.txt | while read REPO_ID; do
        if [ "$REPO_ID" != "" ]; then
            curl -H "X-ArchivesSpace-Session: $ASPACE_API_TOKEN" $ASPACE_API_URL/repositories/$REPO_ID > data-export/repositories/$REPO_ID.json
        fi
    done
    echo "Completed repositories list"
}

getRepository
echo ""
echo "Done."
