# encoding: utf-8
require './include/config.rb'
require 'sinatra'
# require 'mongo_mapper'
# require './model/ntt.rb'

# configure do
#  MongoMapper.setup({'production' => {'uri' => CONFIG['mongodb']['uri']}}, 'production')
# end

get '/' do
  'Welcome to srvinv!'
end

get '/ntts' do
end

get '/ntts/*' do
  params[:splat]
end

post '/ntts' do
  status 201
end

put '/ntts/:name' do
  status 202
end

delete '/ntts/:name' do
  status 202
end
