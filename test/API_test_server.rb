require 'sinatra'
require 'json'
require 'active_support/core_ext/hash/conversions'

# POST /api/stat.online.get?date_from=2013-10-15&date_to=2013-10-16
post '/api/stat.online.get' do
  from = params[:date_from].to_datetime.to_i
  to   = params[:date_to  ].to_datetime.to_i

  data = []
  (from..to).step(1.minutes) { |time| data << Random.rand(200..1000) }

  puts "Array size: #{data.size}. Last element: #{data.last}."

  content_type :json
  data.to_json
  # OUTPUT: [30, 1, 2]
end