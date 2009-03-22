require 'rubygems'
require 'contest'
require File.dirname(__FILE__) + "/../lib/spawner"

class Foo
  attr_accessor :attributes

  def initialize(*args)
    @attributes = Hash.new

    yield self if block_given?

    if args.first
      args.first.each do |key, value|
        @attributes[key] = value
      end
    end
  end

  def save!
  end

  def self.create(attrs = {})
    new(attrs)
  end

  def bar
    attributes[:bar]
  end

  def baz
    attributes[:baz]
  end

  def bar=(value)
    attributes[:bar] = value
  end

  def baz=(value)
    attributes[:baz] = value
  end

  def name
    "Foo"
  end

  extend Spawner

  spawner do |foo|
    foo.bar = 7
    foo.baz = 8
  end
end

class TestFoo < Test::Unit::TestCase
  should "have a name instance method" do
    assert Foo.new.respond_to?(:name)
  end

  context "with attributes :bar and :baz" do
    context "when sent a hash on initialization" do
      should "set the attributes to the passed values" do
        foo = Foo.new :bar => 1, :baz => 2
        assert_equal 1, foo.bar
        assert_equal 2, foo.baz
      end

      context "and a block" do
        should "give priority to the values in the hash" do
          foo = Foo.new(:bar => 5, :baz => 6) { |f| f.baz = 7 }
          assert_equal 5, foo.bar
          assert_equal 6, foo.baz
        end
      end
    end

    context "when sent a block" do
      should "set the attributes from the passed block" do
        foo = Foo.new { |f| f.bar = 3; f.baz = 4 }
        assert_equal 3, foo.bar
        assert_equal 4, foo.baz
      end
    end
  end

  context "that implements Spawner" do
    should "be kind of Spawner" do
      assert Foo.kind_of?(Spawner)
    end

    context "when instantiated with spawn" do
      context "without parameters" do
        should "initialize the instance with the defined block" do
          foo = Foo.spawn
          assert_equal 7, foo.bar
          assert_equal 8, foo.baz
        end
      end

      context "with a hash supplied" do
        should "override the default values" do
          foo = Foo.spawn :bar => 1
          assert_equal 1, foo.bar
          assert_equal 8, foo.baz
        end
      end
    end
  end
end
