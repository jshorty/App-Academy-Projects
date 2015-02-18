require_relative '../phase6/controller_base'
require_relative '../phase6/router'
require_relative '../phase4/session'

class Flash

  def initialize
    @messages = Hash.new {|h, k| h[k] = []}
  end

  def []=(key, value)
    @messages[key] = value
  end

  def [](key)
    @messages[key]
  end
