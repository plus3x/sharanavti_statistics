require 'sinatra'
require 'json'
require 'active_support/core_ext/hash/conversions'

# POST /statistics/between?from=2014-01-21+18%3A04%3A11+%2B0400&to=2014-01-27+18%3A04%3A11+%2B0400
post '/statistics/between' do
  data = []
  from = params[:from].to_datetime.to_i
  to   = params[:to  ].to_datetime.to_i
  (from..to).step(1.minutes) { |time| data << { x: time, y: Random.rand(20..200) }

  puts "Array size: #{data.size}. First element: #{data.first}."

  content_type :json
  data.to_json
end

# GET /statistics/new_dot
get '/statistics/new_dot' do
  dot = { x: Time.now, y: Random.rand(20..200) }

  puts "Dot: #{dot}"

  content_type :json
  dot.to_json
end