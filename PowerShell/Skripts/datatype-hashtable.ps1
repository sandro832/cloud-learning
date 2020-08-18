
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_hash_tables?view=powershell-7

""
"**************************"
"*** Hashtable ***"
""

$hashtable = @{
    "key1"        = "value1"
    "PowerOff"    = "Override"
    "APM"         = "ILCMR"
    "Department"  = "P&C"
    }

$hashtable.gettype()
$hashtable

$hashtable.Keys.ForEach({"$_ "}) -join ' | '

# Add $hashtable["<key>"] overwrites value (no error), adding a duplicate with .Add("<key", "<value>") throws an error
$hashtable["DB"] = "214"
$hashtable["DB"] = "213"
#$hashtable.Add("DB", "215")
$hashtable.Add["DB", "215"]

# Duplicate Remove is ignored, returns nothing
$hashtable.Remove("DB")
$hashtable.Remove("DB")

$hashtable.Remove["DB"]

"Access deleted item: " + $hashtable["DB"]
"Access deleted item: " + $hashtable.Item["DB"]
"Access deleted item: " + $hashtable.Item("DB")  

"Access existing item: " + $hashtable["Department"]

$hashtable


