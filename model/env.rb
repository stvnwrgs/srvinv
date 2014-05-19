# encoding: utf-8
# env model

require './include/config.rb'

class Env
  include MongoMapper::Document

  key :name,         String
  key :description,  String
  timestamps!

  many :nets

  validates_presence_of :name, :created_at, :updated_at

  after_save :call_hooks if CONFIG['hooks']['enabled']

  private
  def call_hooks
    CONFIG['hooks']['enabled_hooks'].each do |hook|
      require './hooks/' + hook + '.rb'
      loaded_hook = Kernel.const_get('Hook_' + hook).new
      loaded_hook.after_save(self)
    end
  end
end
