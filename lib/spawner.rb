module Spawner
  def spawner &default
    @@spawn ||= Hash.new do |hash, key|
      hash[key] = lambda { |model| model }
    end
    @@spawn[self.name] = default
  end

  def spawn(*args)
    model = new(*args, &@@spawn[self.name])
    yield model if block_given?
    model.save!
    model
  end
end
