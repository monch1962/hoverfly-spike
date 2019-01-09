# Hoverfly spike
These are some experiments with how to easily generate stubs to use with Hoverfly (https://github.com/SpectoLabs/hoverfly). The goal is to create stubs for *yet-to-be-developed* backend systems as quickly as possible, then tweak them to become useful

`./new-stub.sh GET https://localhost:8000/blah?a=b 200`
should return a useful Hoverfly stub template to get started with.

`./new-stub.sh GET https://localhost:8000/blah?a=b 200 | ./add-response-headers-from-file.sh sample-headers.json`
should add headers from a JSON file to that template.

`./new-stub.sh GET https://localhost:8000/blah?a=b 200 | ./add-response-body-from-file.sh sample-body.json`
should add a response body from a JSON file to that template.

You get the idea... grab the design specs for the backend system and use them to spit out some Hoverfly stubs to assist with integration testing with that backend system

## Dependencies
- bash shell
- jq
- sed
