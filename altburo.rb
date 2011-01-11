require 'rubygems'
require 'sinatra'
require 'curb'
require 'host'
port = 80
#host = 'local.secondbureau.com'
#port = 3000
host = 'shortener.2bu.ro'
agent = 'SecondBureau Redirector'  # must match use_agent_constraint in 2bu.ro

get '/test_sinatra' do |c|
  "Sinatra is singing"
end

get '/newrelic_2buro' do |c|
  "newrelic OK"
end

get %r{/redirections(.*)} do |c|
  redirect  "http://#{host}/redirections#{c}"
end


get %r{/([A-Za-z0-9_]{6,32}$)} do |c|
  url = "http://#{host}:#{port}/indirect/#{c}"
  curl_handler = Curl::Easy.new(url)
  curl_handler.headers = "User-Agent: #{agent}"
  curl_handler.http_get
  case curl_handler.response_code
  when 200
    redirect curl_handler.body_str
  else
    status 404
    "Not found"
  end
end

get '/^[\.ico]' do |c|
   status 301
   redirect  "http://#{host}/#{c}"
end