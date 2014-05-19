# encoding: utf-8
# srv model
class Srv
  include MongoMapper::Document

  key :name,              String
  key :description,       String
  timestamps!

  key :macs,              Array
  key :interfaces,        Array
  key :cpu_cores,         Integer, default: 1
  key :ram_size_mb,       Integer, default: 1024
  key :disk_size_gb,      Integer, default: 40

  key :os,                String
  key :os_version,        String
  key :os_arch,           String

  key :servicenames,      Array
  key :projectid,         Integer, default: 0

  key :is_provisioned,    Boolean, default: false
  key :provisioned_with,  String
  key :is_deployed,       Boolean, default: false
  key :deployed_with,     String

  belongs_to :net

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
