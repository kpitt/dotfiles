# git -- Example commands for getting useful info

{:data-section="shell"}
{:data-date="September 25, 2025"}

## EXAMPLES

Get a list of branches that include a specific commit:

    git branch --contains <commit_id>

Get a list of tags that include a specific commit:

    git tag --contains <commit_id>

Reset author of most recent commit to match current configuration:

    git commit --amend --reset-author --no-edit

Set a specific author for the most recent commit:

    git commit --amend --author="Author Name <email@address.com>" --no-edit
