# encoding: utf-8
include_path = File.join(File.dirname(__FILE__), '../..', 'include')
model_path = File.join(File.dirname(__FILE__), '../..', 'model')
require File.join(include_path, 'config.rb')
require 'sinatra'
require 'mongo_mapper'
require 'json'
require File.join(model_path, 'env.rb')
require File.join(model_path, 'net.rb')
require File.join(model_path, 'srv.rb')

api_version = 'v1'

configure do
  MongoMapper.setup({ 'production' => { 'uri' => CONFIG['mongodb']['uri'] } }, 'production')
  MongoMapper.database = 'srvinv'
  unless CONFIG['mongodb']['user'].nil?
    MongoMapper.database.authenticate(CONFIG['mongodb']['user'], CONFIG['mongodb']['password'])
  end
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

patch '/' + api_version + '/envs/:name/:attribute' do
  value = JSON.parse(request.env["rack.input"].read)
  @envn = Env.where(:name=>params['name']).first
  return status 404 if @envn.nil?
  @envn[params['attribute']] = value['value']
  @envn.save()
  status 202
end

delete '/' + api_version + '/envs/:name' do
  @envn = Env.where(:name=>params['name']).first
  return status 404 if @envn.nil?
  @envn.delete
  status 202
end

get '/' + api_version + '/nets' do
  @netn = Net.sort(:created_at.desc)
  @netn.to_json
end

get '/' + api_version + '/nets/:name' do
  @netn = Net.where(:name=>params['name']).first
  return status 404 if @netn.nil?
  return @netn.to_json
end

post '/' + api_version + '/nets' do
  given_net = JSON.parse(request.env["rack.input"].read)
  if Net.where(:name=>given_net['name']).empty?
    @net = Net.new(given_net)
    @net.save
    status 201
  else
    status 409
  end
end

put '/' + api_version + '/nets/:name' do
  given_net = JSON.parse(request.env["rack.input"].read)
  @netn = Net.where(:name=>params['name']).first
  return status 404 if @netn.nil?
  @netn.update_attributes(given_net)
  @netn.save()
  status 202
end

patch '/' + api_version + '/nets/:name/:attribute' do
  value = JSON.parse(request.env["rack.input"].read)
  @netn = Net.where(:name=>params['name']).first
  return status 404 if @netn.nil?
  @netn[params['attribute']] = value['value']
  @netn.save()
  status 202
end

delete '/' + api_version + '/nets/:name' do
  @netn = Net.where(:name=>params['name']).first
  return status 404 if @netn.nil?
  @netn.delete
  status 202
end

get '/' + api_version + '/srvs' do
  @srvn = Srv.sort(:created_at.desc)
  @srvn.to_json
end

get '/' + api_version + '/srvs/:name' do
  @srvn = Srv.where(:name=>params['name']).first
  return status 404 if @srvn.nil?
  return @srvn.to_json
end

post '/' + api_version + '/srvs' do
  given_srv = JSON.parse(request.env["rack.input"].read)
  if Srv.where(:name=>given_srv['name']).empty?
    @srv = Srv.new(given_srv)
    @srv.save
    status 201
  else
    status 409
  end
end

put '/' + api_version + '/srvs/:name' do
  given_srv = JSON.parse(request.env["rack.input"].read)
  @srvn = Srv.where(:name=>params['name']).first
  return status 404 if @srvn.nil?
  @srvn.update_attributes(given_srv)
  @srvn.save()
  status 202
end

patch '/' + api_version + '/srvs/:name/:attribute' do
  value = JSON.parse(request.env["rack.input"].read)
  @srvn = Srv.where(:name=>params['name']).first
  return status 404 if @srvn.nil?
  @srvn[params['attribute']] = value['value']
  @srvn.save()
  status 202
end

delete '/' + api_version + '/srvs/:name' do
  @srvn = Srv.where(:name=>params['name']).first
  return status 404 if @srvn.nil?
  @srvn.delete
  status 202
end
