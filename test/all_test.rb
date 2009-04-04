require 'rubygems'
require 'contest'
require File.dirname(__FILE__) + "/../lib/spawner"

class Foo
  attr_accessor :attributes

  def initialize(attrs = {})
    @attributes = attrs
  end

  def self.create!(attrs = {})
    new(attrs)
  end

  def bar; attributes[:bar] end
  def baz; attributes[:baz] end
  def self.name; "Foo" end

  extend Spawner

  spawner do |foo|
    foo.bar = 7
    foo.baz = 8
  end
end

class Bar < Foo
  def self.name; "Bar" end

  spawner do |bar|
    bar.bar = 9
    bar.baz = 10
  end
end

class TestFoo < Test::Unit::TestCase
  should "have a name class method" do
    assert Foo.respond_to?(:name)
    assert_equal "Foo", Foo.name
  end

  context "with attributes :bar and :baz" do
    context "when sent a hash on initialization" do
      should "set the attributes to the passed values" do
        foo = Foo.new :bar => 1, :baz => 2
        assert_equal 1, foo.bar
        assert_equal 2, foo.baz
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

      context "and a class Bar" do
        context "that also implements Spawner" do
          should "be kind of Spawner" do
            assert Bar.kind_of?(Spawner)
          end

          context "when sent :name" do
            should "return 'Bar'" do
              assert_equal "Bar", Bar.name
            end
          end

          context "when sent :spawn" do
            should "return an instance of Bar" do
              assert Bar.spawn.kind_of?(Bar)
            end

            should "not interfere with Foo.spawn" do
              assert_equal 7, Foo.spawn.bar
              assert_equal 9, Bar.spawn.bar
            end
          end
        end
      end
    end
  end
end
