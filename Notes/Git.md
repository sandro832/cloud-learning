# GIT Source control notes

To download repository use this:

git clone https://swissre@dev.azure.com/swissre/CLOUD-Enablement/_git/sandro-training


## Pull Requests

1. git push <branch-name>
2. In Azure DevOps create the pull request.

Maybe you have to make changes/fixes based on feedback.

3. You make the the corrections.
4. Changes may have been made on the "develop" branch. You need to merge them back into your branch.
    - git checkout develop
    - git pull
    - git checkout <branch-name>
    - git merge develop

*The "merge" command is used to integrate changes from another branch.*

The target of this integration (i.e. the branch that receives changes) is always the currently checked out HEAD branch.



