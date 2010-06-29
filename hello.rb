require 'rubygems'
require 'sinatra'

require 'whois'

get '/' do
  "Up"
end

get '/domains/:domain_name' do
  "#{domain_name}"
end