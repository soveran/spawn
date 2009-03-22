require 'ostruct'

module Spawner
  def spawner &default
    @@spawn ||= Hash.new { |hash, key| hash[key] = lambda { |model| model } }
    @@spawn[self.name] = default
  end

  def spawn attrs = {}
    model = OpenStruct.new
    @@spawn[self.name].call(model)
    create(model.send(:table).merge(attrs))
  end
end
