if ($args.Count -ne 1) {
    Write-Output "Expecting to be invoked with 'pwsh add-request-headers-from-file.ps1 REQUEST_HEADERS_JSON_FILE'"
    Write-Output "e.g. 'pwsh add-request-headers-from-file.ps1 sample-headers.json'"
    exit 1
}
$json = @($Input) | ConvertFrom-Json
$new_headers = [IO.File]::ReadAllText($args[0]) | ConvertFrom-Json
$json.data.pairs[-1].request.headers = $new_headers
Write-Output $json | ConvertTo-Json -Depth 10