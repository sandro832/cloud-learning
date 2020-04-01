PowerShell Scopes

PowerShell supports the following scopes:
Global: The scope that is in effect when PowerShell starts. Variables and functions that are present when PowerShell starts have been created in the global scope, such as automatic variables and preference variables. The variables, aliases, and functions in your PowerShell profiles are also created in the global scope.
Local: The current scope. The local scope can be the global scope or any other scope.
Script: The scope that is created while a script file runs. Only the commands in the script run in the script scope. To the commands in a script, the script scope is the local scope.

Parent and Child Scopes

You can create a new scope by running a script or function, by creating a session, or by starting a new instance of PowerShell. When you create a new scope, the result is a parent scope (the original scope) and a child scope (the scope that you created).
In PowerShell, all scopes are child scopes of the global scope, but you can create many scopes and many recursive scopes.
Unless you explicitly make the items private, the items in the parent scope are available to the child scope. However, items that you create and change in the child scope do not affect the parent scope, unless you explicitly specify the scope when you create the items.
Inheritance

A child scope does not inherit the variables, aliases, and functions from the parent scope. Unless an item is private, the child scope can view the items in the parent scope. And, it can change the items by explicitly specifying the parent scope, but the items are not part of the child scope.
However, a child scope is created with a set of items. Typically, it includes all the aliases that have the AllScope option. This option is discussed later in this article. It includes all the variables that have the AllScope option, plus some automatic variables.
To find the items in a particular scope, use the Scope parameter of Get-Variable or Get-Alias.
For example, to get all the variables in the local scope, type:
Get-Variable -Scope local
To get all the variables in the global scope, type:
Get-Variable -Scope global