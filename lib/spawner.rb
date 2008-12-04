module Spawner
  def spawner &default
    @@spawn ||= Hash.new do |hash, key|
      hash[key] = lambda { |model| model }
    end
    @@spawn[self.name] = default
  end

  def spawn attrs = Hash.new
    model = new &@@spawn[self.name]
    model.attributes = attrs unless attrs.empty?
    yield model if block_given?
    model.save!
    model
  end
end
