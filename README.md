# aspace-shell-scripts

A collection of Bash+curl scripts used to pull data from [ArchivesSpace REST API](http://archivesspace.github.io/archivesspace/api/#archivesspace-rest-api).

These scripts use four environment variables

+ ASPACE_API_URL
+ ASPACE_API_TOKEN
+ ASPACE_USERNAME
+ ASPACE_PASSWORD

+ api-login.sh - uses the three ASPACE_* environment variables, authenticates with the API and exports the environment variable ASPACE_API_TOKEN, it also displays a basic curl command string you can use to access the API with that token.
+ export.sh - exports must of the data from an ArchivesSpace instance and saves them to a data-export directory as JSON blobs
+ get-accession.sh - exports the accessions from an ArchivesSpace instance and save them to data-export directory/repositories/REPO_ID/accessions where REPO_ID is the number id for the repository
+ get-agents.sh - exports agents by type to data-export/agents/...
+ get-repositories - exports repository information to data-export/repositories/...

