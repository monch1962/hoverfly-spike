if ($args.Count -ne 1) {
    Write-Output "Expecting to be invoked with 'pwsh add-response-body-from-file.ps1 RESPONSE_BODY_JSON'"
    Write-Output "e.g. 'pwsh add-response-body-from-file.ps1 sample-body.json'"
    exit 1
}
$json = @($Input) | ConvertFrom-Json
$new_headers = [IO.File]::ReadAllText($args[0]) | ConvertFrom-Json
$json.data.pairs[-1].response.headers = $new_headers
Write-Output $json | ConvertTo-Json -Depth 10