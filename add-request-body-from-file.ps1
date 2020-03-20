Import-Module -Name Microsoft.PowerShell.Utility

if ($args.Count -ne 1) {
    Write-Output "Expecting to be invoked with 'pwsh add-request-body-from-file.ps1 REQUEST_BODY'"
    Write-Output "e.g. 'pwsh add-request-body-from-file.ps1 request-body.json'"
    exit 1
}
$json = @($Input) | ConvertFrom-Json
$new_body = [IO.File]::ReadAllText($args[0])
#if ($new_body | Test-Json) {
#    $new_body = ConvertTo-Json $new_body
#}
try {
    $ignore = ConvertFrom-Json $new_body -ErrorAction Stop;
    $bodyIsJson = $true;
} catch {
    $bodyIsJson = $false;
}
if ($bodyIsJson) {
    $new_body = ConvertFrom-Json $new_body
    $json.data.pairs[-1].request.body[-1].matcher = "json"
} else {
    $json.data.pairs[-1].request.body[-1].matcher = "exact"
}
$json.data.pairs[-1].request.body[-1].value = $new_body

Write-Output $json | ConvertTo-Json -Depth 10