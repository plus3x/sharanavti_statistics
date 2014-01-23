require 'sinatra'
require 'json'
require 'active_support/core_ext/hash/conversions'

# Online statistics
# POST /statistics/between?from=2014-01-21+18%3A04%3A11+%2B0400&to=2014-01-27+18%3A04%3A11+%2B0400
post '/statistics/between' do
  data = []
  (params[:from].to_datetime.to_i..params[:to].to_datetime.to_i).step(1.minutes) { |e| data << Random.rand(20..200) }

  content_type :json
  data.to_json
end