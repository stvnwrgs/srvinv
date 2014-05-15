# encoding: utf-8
# srv model
class Srv
  include MongoMapper::Document

  key :name,              String
  key :description,       String
  key :created_at,        Time

  key :interfaces,        Array
  key :cpu_cores,         Integer, default: 1
  key :ram_size_mb,       Integer, default: 1024
  key :disk_size_gb,      Integer, default: 40

  key :servicenames,      Array
  key :projectid,         Integer, default: 0

  key :is_provisioned,    Boolean, default: false
  key :provisioned_with,  String
  key :is_deployed,       Boolean, default: false
  key :deployed_with,     String

  belongs_to :net

  validates_presence_of :name, :description, :created_at, :macs
end
