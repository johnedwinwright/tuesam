require 'sinatra'
require 'open-uri'
require 'uri'
require 'json'


get '/tuesday/' do
  count = 0

    require "net/http"
    require "uri"
    uri = URI.parse("https://recruiting2.ultipro.com/TUE1000/JobBoard/1b3c4479-ea4e-4427-acbe-af4e8cad5cc8/JobBoardView/LoadOpportunities")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    request["Content-Type"] = "application/json; charset=utf-8"
    request.body = "#{{:opportunitySearch =>{:Top => '5000', :Skip => '0'}}.to_json}"
    puts "#{request.body}"
    response = http.request(request)

puts "#{response}"

    @load_opps_response = JSON.parse(response.body)
    puts "#{@load_opps_response}"
@jobs = []
@load_opps_response["opportunities"].each do |opp|

  job = "https://recruiting2.ultipro.com/TUE1000/JobBoard/1b3c4479-ea4e-4427-acbe-af4e8cad5cc8/OpportunityDetail?opportunityId=#{opp["Id"]}"
  @jobs << "#{job}"
end

  erb :index

end
