# encoding: utf-8
require './include/config.rb'
require 'sinatra'
require 'mongo_mapper'
require 'json'
require './model/env.rb'
require './model/net.rb'
require './model/srv.rb'

api_version = 'v1'

configure do
  MongoMapper.setup({ 'production' => { 'uri' => CONFIG['mongodb']['uri'] } }, 'production')
  MongoMapper.database = 'srvinv'
end

get '/' do
  'Welcome to srvinv!'
end

get '/' + api_version + '/envs' do
  @result = Env.sort(:created_at.desc)
  @result.to_json
end

get '/' + api_version + '/envs/:name' do
  @result = Env.where(:name=>params['name']).first
  return status 404 if @result.nil?
  return @result.to_json
end

post '/' + api_version + '/envs' do
  # we need to validate if it's already there
  @env = Env.new(JSON.parse(params['env']))
  @env.save
  status 201
end

put '/' + api_version + '/envs/:name' do
  @env = Env.where(:name=>params['name']).first
  return status 404 if @env.nil?
  @env.update(JSON.parse(params['env']))
  @env.save
  status 202
end

delete '/' + api_version + '/envs/:name' do
  @env = Env.where(:name=>params['name']).first
  return status 404 if @env.nil?
  @env.delete
  status 202
end
