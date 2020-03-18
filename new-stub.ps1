if ($args.Count -ne 3) {
    Write-Output "Expecting to be invoked with 'pwsh new-stub.ps1 HTTP_VERB URL HTTP_RESPONSE_CODE'"
    Write-Output "e.g. 'pwsh new-stub.ps1 GET https://localhost:8000/posts/1 200' or 'pwsh new-stub.ps1 POST https://jsonplaceholder.typicode.com/users 202'"
    exit 1
}

$timestamp = Get-Date -Format o
$method = $args[0]
$url = [uri]$args[1]
$scheme = $url.Scheme
$destination = $url.Authority
$path = $url.LocalPath
$body = ""
$status = $args[2]

$stub = [ordered]@{
    data = @{
        pairs = @(
            @{
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
            }
        )
    };
    meta = @{
        exported = $timestamp;
        schemaVersion = "v5";
        hoverflyVersion = "v0.17.7"
    }
}
Write-Output $stub | ConvertTo-Json -Depth 10