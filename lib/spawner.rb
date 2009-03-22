require 'ostruct'

module Spawner
  def spawner &default
    @@spawn ||= Hash.new
    @@spawn[self.name] = default
  end

  def spawn attrs = {}
    @@spawn[self.name].call(model = OpenStruct.new)
    create(model.send(:table).merge(attrs))
  end
end
