# Advanced Hoverfly investigations

This repo contains some investigations into advanced Hoverfly usage

## Advanced templating

Hoverfly uses https://github.com/aymerick/raymond to implement its templating functionality. This allows you to include some quite sophisiticated logic inside templates

Start with 

`$ hoverctl start webserver`

`$ hoverctl import templates/advanced-template.json`

`$ curl -v http://localhost:8500/test`

Note that the response comes back with values substituted into the template

### Conditional values in templated response

Now try

`$ curl -v -H "abc:123" localhost:8500/test`

Note the value of the Abc-Request-Header response header

Now try

`$ curl -v -H "abc:12345" localhost:8500/test`

and the response header value Abc-Request-Header has a different value & format

Now try

`$ curl -v -H "abd:12345" localhost:8500/test`

and the response header value Abc-Request-Header will be 'no abc request header'

`$ hoverctl stop`

## Middleware

_work in progress_

Run

`$ hoverctl middleware "./middleware/middleware.py"`



## Dockerfile for middleware

It seems to be common to write Hoverfly middleware in Python. A sample Dockerfile for Hoverfly that can run Python middleware is at `./middleware/Dockerfile`



