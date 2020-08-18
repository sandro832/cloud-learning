
""
"**************************"
"*** Dictionary ***"
""

$dictionary = New-Object 'system.collections.generic.dictionary[string,string]'
$dictionary.Add("key1", "value1")
$dictionary.Add("PowerOff", "Override")
$dictionary.Add("APM", "ILCMR")
$dictionary.Add("Department", "P&C")

$dictionary.gettype()


$dictionary.Keys.ForEach({"$_ "}) -join ' | '

# Add $dictionary["<key>"] = "<value>" overwrites value (no error), adding a duplicate with .Add("<key", "<value>") throws an error

$dictionary["DB"] = "214"
$dictionary["DB"] = "213"
$dictionary.Add("DB", "215")   # throws an error
$dictionary.Add["DB", "215"]

"Remove called twice:"
$dictionary.Remove("DB") #returns true
$dictionary.Remove("DB") #returns false

$dictionary.Remove["DB"]

"Add new item returns no bool: " + $dictionary.Add("Checker", "215") # doesn't return true/false

"Access deleted item: " + $dictionary["DB"]
"Access deleted item: " + $dictionary.Item["DB"]

"Access deleted item: " + $dictionary.Item("DB")  #will throw an error

"Access existing item" + $dictionary["Department"]

"ContainsKey " + $dictionary.ContainsKey("DB")

$dictionary

