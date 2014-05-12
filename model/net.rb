# encoding: utf-8
# net model
class Net
  include MongoMapper::Document

  key :name,         String
  key :description,  String
  key :created_at,   Time

  key :provider,     String
  key :netmask,      String
  key :gateway,      String
  key :broadcast,    String

  many :srvs
  belongs_to :env

  validates_presence_of :name, :description, :created_at
end
