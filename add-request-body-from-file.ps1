if ($args.Count -ne 1) {
    Write-Output "Expecting to be invoked with 'pwsh add-request-body-from-file.ps1 JSON_REQUEST_BODY'"
    Write-Output "e.g. 'pwsh add-request-body-from-file.ps1 request-body.json'"
    exit 1
}
$json = @($Input) | ConvertFrom-Json
$new_body = [IO.File]::ReadAllText($args[0])
$json.data.pairs[-1].request.body = $new_body
Write-Output $json | ConvertTo-Json -Depth 10