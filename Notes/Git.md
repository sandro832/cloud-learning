# GIT Source control notes

To download repository use this:

git clone https://swissre@dev.azure.com/swissre/CLOUD-Enablement/_git/sandro-training

## Git Setup
git config --global user.name "Firstname Lastname" 
git config --global user.email Firstname_Lastname@swissre.com

git config --global http.proxy http://gate.zrh.swissre.com:8080

https://artifact.swissre.com/software/DPS/git/sr-ca-bundle.crt  Zertifikat herunterladen in Verzeichniss %USERPROFILE%.

git config --global http.sslcainfo C:\Users\st18c\sr-ca-bundle.crt 

git config -l --global



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



