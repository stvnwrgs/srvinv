# encoding: utf-8
# net model
class Net
  include MongoMapper::Document

  key :name,         String
  key :description,  String
  timestamps!

  key :provider,     String
  key :netmask,      String
  key :gateway,      String
  key :broadcast,    String

  many :srvs
  belongs_to :env

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
