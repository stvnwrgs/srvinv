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
  @envs = Env.sort(:created_at.desc)
  @envs.to_json
end

get '/' + api_version + '/envs/:name' do
  @envn = Env.where(:name=>params['name']).first
  return status 404 if @envn.nil?
  return @envn.to_json
end

post '/' + api_version + '/envs' do
  given_env = JSON.parse(request.env["rack.input"].read)
  if Env.where(:name=>given_env['name']).empty?
    @env = Env.new(given_env)
    @env.save
    status 201
  else
    status 409
  end
end

put '/' + api_version + '/envs/:name' do
  given_env = JSON.parse(request.env["rack.input"].read)
  @envn = Env.where(:name=>params['name']).first
  return status 404 if @envn.nil?
  @envn.update_attributes(given_env)
  @envn.save()
  status 202
end

delete '/' + api_version + '/envs/:name' do
  print 'narf'
  @envn = Env.where(:name=>params['name']).first
  return status 404 if @envn.nil?
  @envn.delete
  status 202
end
