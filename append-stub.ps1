if ($args.Count -ne 3) {
    Write-Output "Expecting to be invoked with 'pwsh append-stub.ps1 HTTP_VERB URL HTTP_RESPONSE_CODE''"
    exit 1
}
$json = @($Input) | ConvertFrom-Json
$method = $args[0]
$url = [uri]$args[1]
$scheme = $url.Scheme
$destination = $url.Authority
$path = $url.LocalPath
$body = ""
$status = $args[2]

$new_stub = [ordered]@{
    request = [ordered]@{
        path = @(
            @{
                matcher = "exact";
                value = $path;
            };
        )
        method = @(
            @{
                matcher = "exact";
                value = $method;
            };
        )
        destination = @(
            @{
                matcher = "exact";
                value = $destination;
            };
        )
        scheme = @(
            @{
                matcher = "exact";
                value = $scheme;
            };
        )
        body = @(
            @{
                matcher = "exact";
                value = $body;
            };
        )
        headers = @{};
        query = @{}
    };
    response = [ordered]@{
        status = [int]$status;
        body = "nothing";
        encodedBody = $false;
        headers = @{};
        templated = $false;

    }
};

$json.data.pairs += $new_stub
Write-Output $json | ConvertTo-Json -Depth 10