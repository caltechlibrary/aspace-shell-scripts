# aspace-shell-scripts

A collection of Bash+curl scripts used to pull data from [ArchivesSpace REST API](http://archivesspace.github.io/archivesspace/api/#archivesspace-rest-api).

These scripts use two environment variables

+ ASPACE_API_URL
+ ASPACE_API_TOKEN

+ api-login.sh - an interactive shell command that populates the ASPACE_API_TOKEN environment variable used by the other scripts
+ api-logout.sh - sourcing this script clears the values in ASPACE_API_URL and ASPACE_API_TOKEN after trying to send a /logout to ASPACE_API_URL
+ export.sh - exports much of the data from an ArchivesSpace instance (e.g. agents, accessions, repository info) and saves them to a data-export directory as JSON blobs
    + get-accession.sh - exports the accessions from an ArchivesSpace instance and save them to data-export directory/repositories/REPO_ID/accessions where REPO_ID is the number id for the repository
    + get-agents.sh - exports agents by type to data-export/agents/...
    + get-repositories - exports repository information to data-export/repositories/...

Basic usage is to source the _api-login.sh_ script first to populate the ASPACE_API_TOKEN. Then run _export.sh_ and then source _api-logout.sh_.

```shell
    . api-login.sh  # answer the prompts
    bash export.sh  # this will export all the data based on the previous login
    . api-logout.sh # Clear the two environment variables used by this get-*.sh scripts
```
