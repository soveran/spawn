module ActiveRecord
  class Base
    @@spawn = Hash.new do |hash, key|
      hash[key] = lambda { |model| model }
    end

    def self.spawner &default
      @@spawn[self.name] = default
    end

    def self.spawn
      model = new &@@spawn[self.name]
      yield model if block_given?
      model.save!
      model
    end
  end
end
