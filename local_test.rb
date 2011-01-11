

require 'net/http'
require 'uri'


          daryl   = ENV['DARYL'] || 'localhost:4567'
          url     = "http://#{daryl}/page/create"
          agent   = 'request.env["HTTP_USER_AGENT"]'
          host    = 'request.host'
          uri     = 'request.fullpath'
          ip      = '123456'
          Net::HTTP.post_form(URI.parse(url), {'page[ip]'=>ip, 'page[host]'=>host, 'page[agent]' => agent, 'page[uri]' => uri})

