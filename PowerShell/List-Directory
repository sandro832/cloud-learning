param(
    [Parameter(Mandatory = $true)]
    [String] $TargetDirectory
)

[int] $global:bigestFileLength = 0
[string] $global:bigestFileName = ""


function ShowFile {
    Param ([object]$fileInformation)
    
    If ($file.Length -gt $global:bigestFileLength) {
        $global:bigestFileLength = $file.Length 
        $global:bigestFileName = $file.Fullname
    }  

    Write-Host  "`t`t", $file.Name, ($file.Length / 1Mb)
    
    If ($file.Length -gt 10MB) { 
        Write-Host $file.Fullname -BackgroundColor red 
    }
    ElseIf ($file.Length -gt 1MB) { 
        Write-Host $file.Fullname -BackgroundColor green 
    }
    Else { 
        Write-Host $file.Fullname -BackgroundColor white 
    }
}  
 

function ListFiles {
    Param ([string]$targetDirectory)
    
    $files = Get-ChildItem $targetDirectory
    
    Write-Host $targetDirectory, "dir" 
    
    foreach ($file in $files) {
        switch ($file.Mode) {
            "-a----" { 
                ShowFile $file
            }
            "d-----" {
                Write-Host "<DIR>`t", $file.Name    
            }
        }  
    }  
    foreach ($file in $files) {    
        if ($file.Mode -eq "d-----") {
            ListFiles $file.FullName
        }
    }
}


ListFiles $TargetDirectory 
Write-Host $global:bigestFileName, ($global:bigestFileLength / 1Mb), "Is the bigest file"
