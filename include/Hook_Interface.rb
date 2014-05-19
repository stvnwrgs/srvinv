# encoding: utf-8
# Hook interface for srvinv hooks
class Hook_Interface
  def after_save
    raise NotImplementedError, "Implement this method in a child class"
  end
end
