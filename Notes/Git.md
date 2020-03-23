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

## MD formating

###Headers

# This is an <h1> tag
## This is an <h2> tag
###### This is an <h6> tag

### Emphasis

*This text will be italic*
_This will also be italic_

**This text will be bold**
__This will also be bold__

_You **can** combine them_

### Lists
Unordered

* Item 1
* Item 2
  * Item 2a
  * Item 2b

### Ordered

1. Item 1
1. Item 2
1. Item 3
   1. Item 3a
   1. Item 3b

### Images

![GitHub Logo](/images/logo.png)
Format: ![Alt Text](url)

### Links

http://github.com - automatic!
[GitHub](http://github.com)

### Blockquotes

As Kanye West said:

> We're living the future so
> the present is our past.

### Inline code

I think you should use an
`<addr>` element here instead.

### Tables

You can create tables by assembling a list of words and dividing them with hyphens - (for the first row), and then separating each column with a pipe |:

First Header | Second Header
------------ | -------------
Content from cell 1 | Content from cell 2
Content in the first column | Content in the second column


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



