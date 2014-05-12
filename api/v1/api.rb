# encoding: utf-8
require './include/config.rb'
require 'sinatra'
require 'mongo_mapper'
require './model/env.rb'
require './model/net.rb'
require './model/srv.rb'

configure do
  MongoMapper.setup({ 'production' => { 'uri' => CONFIG['mongodb']['uri'] } }, 'production')
  MongoMapper.database = 'srvinv'
end

get '/' do
  'Welcome to srvinv!'
end

get '/envs' do
  @result = Env.sort(:created_at.desc)
end

get '/envs/:name' do
  @result = Env.where(:name=>params['name']).first
  return status 404 if @result.nil?
end

post '/envs' do
  # we need to validate if it's already there
  @env = Env.new(params['env'])
  @env.save
  status 201
end

put '/envs/:name' do
  @env = Env.where(:name=>params['name']).first
  return status 404 if @env.nil?
  @env.update(params['name'])
  @env.save
  status 202
end

delete '/envs/:name' do
  @env = Env.where(:name=>params['name']).first
  return status 404 if @env.nil?
  @env.delete
  status 202
end
