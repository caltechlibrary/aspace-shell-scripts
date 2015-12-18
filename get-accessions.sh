#!/bin/bash

# Sanity check
if [ "$ASPACE_API_URL" = "" ] || [ "$ASPACE_API_TOKEN" = "" ]; then
    echo "You need to setup your environment variables for accessing your ArchivesSpace deployment"
    exit 1
fi

echo "Accessing ArchivesSpace via $ASPACE_API_URL"

function getAccessions {
    REPO_ID=$1
    echo "Setting up data directory for repositories/$REPO_ID/accessions"
    mkdir -p data-export/repositories/$REPO_ID/accessions
    # Get a list of all agents ids
    echo "Getting ids for /repositories/$REPO_ID/accessions"
    curl -H "X-ArchivesSpace-Session: $ASPACE_API_TOKEN" $ASPACE_API_URL/repositories/$REPO_ID/accessions?all_ids=true | sed -E "s/\[//;s/,/ /g;s/]//" | tr " " "\n" > data-export/$REPO_ID-accession-ids.txt

    # Now for each agent id in data-export/agents-*-ids.txt get a full record.
    echo "Reading /repositories/$REPO_ID/accessions ids and fetch their JSON records "
    cat data-export/$REPO_ID-accession-ids.txt | while read ACCESSION_ID; do
        if [ "$ACCESSION_ID" != "" ]; then
            curl -H "X-ArchivesSpace-Session: $ASPACE_API_TOKEN" $ASPACE_API_URL/repositories/$REPO_ID/accessions/$ACCESSION_ID > data-export/repositories/$REPO_ID/accessions/$ACCESSION_ID.json
        fi
    done
    echo "Completed Accession dump for repository $REPO_ID"
}

if [ "$1" = "" ]; then
    echo 'You need to provide a repository id number for the accessions. E.g.'
    echo '      bash get-accessions.sh 2'
    exit 1
fi
getAccessions $1
echo ""
echo "Done."
