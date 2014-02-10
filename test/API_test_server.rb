require 'sinatra'
require 'json'
require 'active_support/core_ext/hash/conversions'

# GET /api/stat.online.get?date_from=2013-10-15&date_to=2013-10-16
get '/api/stat.online.get' do
  puts "Params: #{params}"

  from = params[:date_from].to_datetime.to_i
  to   = params[:date_to  ].to_datetime.to_i + Time.now.gmt_offset

  data = []
  (from..to).step(1.minutes) { |time| data << Random.rand(0..100) }

  puts "Array size: #{data.size}. Last element: #{data.last}."

  data.to_s
  # OUTPUT: [30, 1, 2]
end
