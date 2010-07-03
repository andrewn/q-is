require 'rubygems'
require 'sinatra'

require 'json'
require 'whois'

class Whois::Answer
  def to_json(*a)   
    props = {}
    Whois::Answer::Parser::PROPERTIES.each do | prop |
      props[prop.to_s] = eval( prop.to_s ) unless prop == :disclaimer
    end
    return props.to_json(*a)
  end
end

get '/' do
  "Up"
end

get '/domain/:domain_name' do | domain |
  content_type :json
  answer = Qis.domain_info_for(domain)
  JSON.pretty_generate answer
end

get '/domain/:domain_name/available' do | domain |
  answer = Qis.domain_info_for(domain)
  answer.available?.to_s
end

class Qis
  def self.domain_info_for( domain )
    w = Whois::Client.new
    answer = w.query( domain )
    answer
  end
end
  