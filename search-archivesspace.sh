#!/bin/bash

# Sanity check
if [ "$1" = "" ] || [ "$2" = "" ]; then
    echo "Usage: bash search-archivesspace.sh PAGE_NO QUERY_STRING"
    exit 1
fi
if [ "$ASPACE_API_URL" = "" ] || [ "$ASPACE_API_TOKEN" = "" ]; then
    echo "You need to setup your environment variables for accessing your ArchivesSpace deployment"
    exit 1
fi

pg_no=$1
shift
#echo "page: $page"
#echo "query: $@"
curl -H "X-ArchivesSpace-Session: $ASPACE_API_TOKEN" "$ASPACE_API_URL/search?page=$pg_no&q=$@" |  jq -r .
