# encoding: utf-8
include_path = File.join(File.dirname(__FILE__), '..', 'include')
require File.join(include_path, 'Hook_Interface.rb')

class Hook_localchangelog < Hook_Interface
  def after_save(resource)
    @@helper.initialize_logging('localchangelog.log')
    @@helper.log('info', resource.to_json)
  end
end
