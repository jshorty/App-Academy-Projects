require_relative '../phase6/controller_base'
require_relative '../phase6/router'
require_relative '../phase4/session'
require_relative '../phase5/params'

class Flash
  attr_accessor :now
  attr_reader :sent

  def initialize
    @messages = Hash.new {|h, k| h[k] = []}
    @now = Hash.new {|h, k| h[k] = []}
    @sent = false
  end

  def []=(key, value)
    @messages[key] = value
  end

  def [](key)
    @messages[key]
  end

end
