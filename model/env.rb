# encoding: utf-8
# env model
class Env
  include MongoMapper::Document

  key :name,         String
  key :description,  String
  key :created_at,   Time

  many :nets

  validates_presence_of :name, :created_at
end
