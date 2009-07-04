require "ostruct"

module Spawn

  Invalid = Class.new(ArgumentError)

  def spawner &default
    @@spawn ||= Hash.new
    @@spawn[self] = default
  end

  def spawn params = {}
    model = new

    # Grab default parameters from spawner block.
    @@spawn[self].call(attrs = OpenStruct.new(params))

    # Assign attributes to model.
    attrs.send(:table).merge(params).each do |key, value|
      model.send("#{key}=", value)
    end

    # Yield model for changes to be made before saving.
    yield(model) if block_given?

    # Return the model if it's valid and can be saved.
    model.valid? and model.save or raise(Invalid)

    model
  end
end
