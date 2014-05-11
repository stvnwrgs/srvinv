# encoding: utf-8
# ntt model
class Ntt
  include MongoMapper::Document

  key :name,     String
  key :value,     String
  key :timestamp, Integer, default: 0

  alidates_presence_of :name, :value, :timestamp
end
