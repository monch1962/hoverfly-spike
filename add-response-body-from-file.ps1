if ($args.Count -ne 1) {
    Write-Output "Expecting to be invoked with 'pwsh add-response-from-file.ps1 RESPONSE_BODY_JSON'"
    Write-Output "e.g. 'pwsh add-response-body-from-file.ps1 sample-body.json'"
    exit 1
}
$json = @($Input) | ConvertFrom-Json
$new_body = [IO.File]::ReadAllText($args[0])
$json.data.pairs[-1].response.body = $new_body
Write-Output $json | ConvertTo-Json -Depth 10