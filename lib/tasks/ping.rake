desc 'Pings site url to keep dyno alive'

task :ping do
  require 'net/http'

  uri = URI('http://www.postco.in')
  Net::HTTP.get_response(uri)
end
