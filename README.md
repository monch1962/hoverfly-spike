# Hoverfly spike
These are some experiments with how to easily generate stubs to use with Hoverfly (https://github.com/SpectoLabs/hoverfly). The goal is to create stubs for *yet-to-be-developed* backend systems as quickly as possible, then tweak them to become useful for building integration tests with those backend systems.

## Dependencies
Either
- bash shell
- jq
- sed

or
- Powershell

## Examples

### Powershell

`pwsh new-stub.ps1 GET https://localhost:8000/blah?a=b 200`
should return a useful Hoverfly stub template to get started with.

`pwsh new-stub.ps1 GET https://localhost:8000/blah?a=b 200 | pwsh add-response-headers-from-file.ps1 sample-headers.json`
should add response headers from a JSON file to that template.

`pwsh new-stub.ps1 GET https://localhost:8000/blah?a=b 200 | pwsh add-response-body-from-file.ps1 sample-body.json`
should add a response body from a JSON file to that template.

`pwsh new-stub.ps1 GET https://localhost:8000/blah?a=b 200 | pwsh add-response-body-from-file.ps1 sample-body.xml`
should add an escaped XML response body from a file to that template.


### bash + jq + sed
`./new-stub.sh GET https://localhost:8000/blah?a=b 200`
should return a useful Hoverfly stub template to get started with.

`./new-stub.sh GET https://localhost:8000/blah?a=b 200 | ./add-response-headers-from-file.sh sample-headers.json`
should add response headers from a JSON file to that template.

`./new-stub.sh GET https://localhost:8000/blah?a=b 200 | ./add-response-body-from-file.sh sample-body.json`
should add a response body from a JSON file to that template.

`./new-stub.sh GET https://localhost:8000/blah?a=b 200 | ./add-response-body-from-file.sh sample-body.xml`
should add an escaped XML response body from a file to that template.

You get the idea...
