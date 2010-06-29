require 'rubygems'
require 'sinatra'

require 'json'
require 'whois'

class Whois::Answer
  def to_json(*a)   
    props = {}
    Whois::Answer::Parser::PROPERTIES.each do | prop |
      props[prop.to_s] = eval( prop.to_s )
    end
    return props.to_json(*a)
  end
end

get '/' do
  "Up"
end

get '/domains/:domain_name' do | domain |
  w = Whois::Client.new
  answer = w.query( domain )
  JSON.pretty_generate answer
end