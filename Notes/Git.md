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

### Username @mentions

Typing an @ symbol, followed by a username, 
will notify that person to come and view the comment. 
This is called an “@mention”, because you’re mentioning the individual. 
You can also @mention teams within an organization.

## Create Token for Accses

Sign in to your organization in Azure DevOps (https://dev.azure.com/{yourorganization})

From your home page, open your user settings, and then select Profile.

My profile Team Services

Under Security, select Personal access tokens, and then select + New Token.

Select New Token to create

Name your token, select the organization where you want to use the token, and then choose a lifespan for your token.

Enter basic token information

Select the scopes for this token to authorize for your specific tasks.

For example, to create a token to enable a build and release agent to authenticate to Azure DevOps Services, limit your token's scope to Agent Pools (Read & manage). To read audit log events, and manage and delete streams, select Read Audit Log, and then select Create.

Select scopes for your PAT

When you're done, make sure to copy the token. You'll use this token as your password.

Copy the token to your clipboard

Use your personal access token

Your token is your identity and represents you when it's used. Keep your tokens secret and treat them like your password.

See the following examples of using your PAT.

  Username: yourPAT
  Password: yourPAT

or

git clone https://anything:{yourPAT}@dev.azure.com/yourOrgName/yourProjectName/_git/yourRepoName

To keep your token more secure, use credential managers so you don't have to enter your credentials every time. We recommend the following credential managers:

Git Credential Manager for macOS and Linux
Git Credential Manager for Windows (requires Git for Windows)

Revoke personal access tokens to remove access

When you don't need your token anymore, revoke it to remove access.

Note

To enable the new user interface for the Project Permissions Settings Page, see Enable preview features.

    Preview page
    Current page

From your home page, open your user settings, and then select Profile.

My profile Team Services

Under Security, select Personal access tokens. Select the token for which you want to revoke access, and then select Revoke.

Revoke a token or all tokens

Select Revoke in the confirmation dialog.

Confirm revoke

Related articles

For more information about how security and identity are managed, see About security and identity.
For more information about permissions and access levels for common user tasks, see Default permissions and access for Azure DevOps.
For more information about how administrators can revoke organization user PATs, see Revoke other users' personal access tokens.

Frequently asked questions (FAQs)
Q: What is my Azure DevOps Services URL?

A: https://dev.azure.com/ {your organization}
Q: Is there a way to renew a PAT via REST API?

A: No, we don't have a REST API to renew a PAT. You can only renew a PAT within the user interface (UI).
Q: Can I use basic auth with all of Azure DevOps REST APIs?

A: No. You can use basic auth with most of them, but organizations and profiles only support OAuth.
Q: Where can I learn more about how to use PATs?

A: For examples of how to use PATs, see Git credential managers, REST APIs, NuGet on a Mac, and Reporting clients.
Q: Can I regenerate a PAT?

A: No, but you can extend a PAT or modify its scope.
Q: What notifications will I get about my PAT?

A: Users receive two notifications during the lifetime of a PAT, one at creation and the other seven days before the expiration.

The following notification is sent at PAT creation:

PAT creation

The following notification is sent - a PAT is near expiration:

PAT near expiration notification
Q: What does "full access" mean?

A: The user has all access.
Q: What do I do if I get an unexpected PAT notification?

A: An administrator or a tool might have created a PAT on your behalf. See the following examples:

    When you connect to an Azure DevOps Git repo through git.exe. it creates a token with a display name like "git: https://MyOrganization.visualstudio.com/ on MyMachine."
    When you or an admin sets up an Azure App Service web app deployment, it creates a token with a display name like "Service Hooks: : Azure App Service: : Deploy web app."
    When you or an admin sets up web load testing, as part of a pipeline, it creates a token with a display name like "WebAppLoadTestCDIntToken".
    When a Microsoft Teams Integration Messaging Extension is set up, it creates a token with a display name like "Microsoft Teams Integration".

If you still believe that a PAT exists in error, we suggest that you revoke the PAT. Next, change your password. As an Azure Active Directory user, check with your administrator to see if your organization was used from an unknown source or location.
Q: How can I use a PAT in my code?

A: See the following sample that gets a list of builds using curl.

curl -u username[:{personalaccesstoken}] https://dev.azure.com/{organization}/_apis/build-release/builds


If you wish to provide the PAT through an HTTP header, first convert it to a Base64 string (the following example shows how to convert to Base64 using C#). The resulting string can then be provided as an HTTP header in the following format:
Authorization: Basic BASE64USERNAME:PATSTRING
Here it is in C# using the HttpClient class.

public static async void GetBuilds()
{
    try
    {
        var personalaccesstoken = "PATFROMWEB";

        using (HttpClient client = new HttpClient())
        {
            client.DefaultRequestHeaders.Accept.Add(
                new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));

            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Basic",
                Convert.ToBase64String(
                    System.Text.ASCIIEncoding.ASCII.GetBytes(
                        string.Format("{0}:{1}", "", personalaccesstoken))));

            using (HttpResponseMessage response = client.GetAsync(
                        "https://dev.azure.com/{organization}/{project}/_apis/build/builds?api-version=5.0").Result)
            {
                response.EnsureSuccessStatusCode();
                string responseBody = await response.Content.ReadAsStringAsync();
                Console.WriteLine(responseBody);
            }
        }
    }
    catch (Exception ex)
    {
        Console.WriteLine(ex.ToString());
    }
}


Tip

When you're using variables, add a "$" at the beginning of the string, like the following example.

public static async void GetBuilds()
{
    try
    {
        var personalaccesstoken = "PATFROMWEB";

        using (HttpClient client = new HttpClient())
        {
            client.DefaultRequestHeaders.Accept.Add(
                new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));

            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Basic",
                Convert.ToBase64String(
                    System.Text.ASCIIEncoding.ASCII.GetBytes(
                        string.Format("{0}:{1}", "", personalaccesstoken))));

            using (HttpResponseMessage response = client.GetAsync(
                        $"https://dev.azure.com/{organization}/{project}/_apis/build/builds?api-version=5.0").Result)
            {
                response.EnsureSuccessStatusCode();
                string responseBody = await response.Content.ReadAsStringAsync();
                Console.WriteLine(responseBody);
            }
        }
    }
    catch (Exception ex)
    {
        Console.WriteLine(ex.ToString());
    }
}


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

## .git Folder

The .git folder contains all the information that is necessary for your project in version control and all the information about commits, remote repository address, etc. All of them are present in this folder. It also contains a log that stores your commit history so that you can roll back to history.

### Objects/[0-9a-f][0-9a-f]

A newly created object is stored in its own file. The objects are splayed over 256 subdirectories using the first two characters of the sha1 object name to keep the number of directory entries in objects itself to a manageable number. Objects found here are often called unpacked (or loose) objects.

### objects/pack

Packs (files that store many objects in compressed form, along with index files to allow them to be randomly accessed) are found in this directory.

### objects/info

Additional information about the object store is recorded in this directory.

## refs

References are stored in subdirectories of this directory. The git prune command knows to preserve objects reachable from refs found in this directory and its subdirectories. 

### refs/heads/name

records tip-of-the-tree commit objects of branch name.

### refs/tags/name

records any object name (not necessarily a commit object, or a tag object that points at a commit object).

### refs/remotes/name

records tip-of-the-tree commit objects of branches copied from a remote repository.

## Head 

Shows the current brach that you are in.

## config 

This is the config file of git with your prefereces.

## Logs

Records of cahnges made to refs are stored in this directory. 

### logs/refs/heads/name

Records all changes made to the branch tip named name.

### logs/refs/tags/name

Records all changes made to the tag named name.

## Worktrees

Contains administrative data for linked working trees. Each subdirectory contains the working tree-related part of a linked working tree. 

## Merge

Merging is a common practice for developers using version control systems. Whether branches are created for testing, bug fixes, or other reasons, merging commits changes to another location. To be more specific, merging takes the contents of a source branch and integrates them with a target branch. In this process, only the target branch is changed. The source branch history remains the same.

Pros:
  1. Simple and familiar.
  1. Preserves complete history and chronological order.
  1. Maintains the context of the branch.

Contras:
  1. Commit history can become polluted by lots of merge commits.
  1. Debbuging using git bisect can become harder.


## rebase 

Rebase is another way to integrate changes from one branch to another. Rebase compresses all the changes into a single “patch.” Then it integrates the patch onto the target branch.

Unlike merging, rebasing flattens the history because it transfers the completed work from one branch to another. In the process, unwanted history is eliminated.

Pros: 
  1. Streamlines a potentially complex history.
  1. Manipulating a singel commmit is easy.
  1. Avoids merge commit "noise in busy repos with busy branches.
  1. Cleans intermidiate commits by making them to one.

Contras:
  1. Rebasing public repositories can be dangerous when working as a team.
  1. Squashing the feature down to a handful of commits can hide the context.
  1. It’s more work: Using rebase to keep your feature branch updated always.


