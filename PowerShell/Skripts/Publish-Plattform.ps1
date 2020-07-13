
Function Publish-Platform {
    [cmdletbinding()]
    Param (
        [string]$UploadFile
        )

    $SasToken = "?sv=2019-10-10&ss=b&srt=co&sp=rwdlacx&se=2020-05-06T14:46:35Z&st=2020-05-06T06:46:35Z&spr=https&sig=s19lSsidB2zv3z2SD6Qfj8sx0c4rdhz44Q28SqfQ%2FXY%3D"
    $ContainerName = "platform"
    $AccountName = "stabilo"

    $blobName = Split-Path $UploadFile -leaf

    Write-Verbose "Uploading $fileName"

    $storage = New-AzStorageContext -StorageAccountName $AccountName -Protocol Https -SasToken $SasToken

    $result = Set-AzStorageBlobContent -File $UploadFile -Container $ContainerName -Blob $blobName -context $storage
   
    $result.ICloudBlob.Uri.AbsoluteUri + $SasToken

    # (Get-AzStorageBlob -Container $ContainerName -Blob $blobName -context $storage).ICloudBlob.uri.AbsoluteUri
}