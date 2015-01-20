require 'sinatra'
require 'dotenv'
Dotenv.load
require_relative 'lib/mail_service'

before do
  content_type :json
  headers "Content-Type" => "text/html; charset=utf8"
  headers 'Access-Control-Allow-Origin' => "*"
end

post '/send' do
  response = {}
  result = MailService.deliver!(params["name"], params["question"])
  isValid? = result['status'] == 'sent' && params['spam'].empty?
  status isValid? 200 ? : 400
end

