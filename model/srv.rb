# encoding: utf-8
# srv model
class Srv
  include MongoMapper::Document

  key :name,              String
  key :description,       String
  key :created_at,        Time

  key :cpu_cores,         Integer, default: 1
  key :ram_size_mb,       Integer, default: 1024
  key :disk_size_gb,      Integer, default: 40
  key :services,          Array
  key :is_provisioned,    Boolean, default: false
  key :provisioned_with,  String

  belongs_to :net

  validates_presence_of :name, :description, :created_at
end
