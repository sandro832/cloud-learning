

About Hashtables 
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_hash_tables?view=powershell-7


| |Hashtable|Dictionary|
|---|---|---|
|Duplicate Add|||
|```$x.Add("key", "value")```|overwrite|overwrite|
|```$x("key") = "value"```|error|error|
|```$x["key"] = "value"```|ignored|ignored|
|Duplicate Remove|||
|```$x.Remove("key")```|ignored|false bool value|
|```$x.Remove["key"]```|ignored|ignored|
|Get Deleted Item|||
|```$x("key")```|blank|blank|
|```$x["key"]```|blank|blank|
|```$x.Item("key")```|blank|error|
|```$x.Item["key"]```|blank|blank|
