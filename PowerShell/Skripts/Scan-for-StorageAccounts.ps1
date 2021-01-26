$skuList = @{}
$kindList = @{}
$accounts = Get-AzStorageAccount

foreach($acc in $accounts)  
{  
    write-host -ForegroundColor green $acc.Sku.Name 
    write-host -ForegroundColor red $acc.Kind

 
    if (-not($skuList.ContainsKey($acc.Sku.Name))) {
        $skuList.add($acc.Sku.Name, 1);
    }  
    else { 
       $count = $skuList.Get_Item($acc.Sku.Name);
       $count = $count + 1
       $skuList.Set_Item($acc.Sku.Name, $count)
    }


    if (-not($kindList.ContainsKey($acc.Kind))) {
        $kindList.Add($acc.Kind, 1);
    }
    else { 
       $kindcount = $kindList.Get_Item($acc.Kind);
       $kindcount = $kindcount + 1
       $kindList.Set_Item($acc.Kind, $kindcount)
    }
}

 
foreach($skuName in $skuList.Keys)  
{
     write-host -ForegroundColor Yellow $skuName " - " $skuList.Get_Item($skuName) 
} 


foreach($kind in $kindList.Keys)  
{
     write-host -ForegroundColor Yellow $kind " - " $kindList.Get_Item($kind) 
} 