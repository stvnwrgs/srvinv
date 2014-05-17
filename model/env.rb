# encoding: utf-8
# env model
class Env
  include MongoMapper::Document

  key :name,         String
  key :description,  String
  timestamps!

  many :nets

  validates_presence_of :name, :created_at, :updated_at
end
