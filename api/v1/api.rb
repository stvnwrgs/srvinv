# encoding: utf-8
require './include/config.rb'
require 'sinatra'
require 'mongo_mapper'
require './model/env.rb'
require './model/net.rb'
require './model/srv.rb'

configure do
  MongoMapper.setup({ 'production' => { 'uri' => CONFIG['mongodb']['uri'] } }, 'production')
end

get '/' do
  'Welcome to srvinv!'
end

get '/envs' do
end

get '/envs/*' do
  params[:splat]
end

post '/envs' do
  status 201
end

put '/envs/:name' do
  status 202
end

delete '/envs/:name' do
  status 202
end
