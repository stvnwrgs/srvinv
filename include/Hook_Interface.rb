# encoding: utf-8
# Hook interface for srvinv hooks
include_path = File.join(File.dirname(__FILE__), '..', 'include')
require File.join(include_path, 'config.rb')
require File.join(include_path, 'srvinvhelper.rb')

class Hook_Interface
  @@helper = Srvinvhelper.new

  def after_save
    raise NotImplementedError, "Implement this method in a child class"
  end
end
