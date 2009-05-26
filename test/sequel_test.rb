require "rubygems"
require "sequel"
require "contest"
require File.dirname(__FILE__) + "/../lib/spawner"
require "faker"

DB = Sequel.sqlite
DB << "CREATE TABLE sequel_users (name VARCHAR(255) NOT NULL, email VARCHAR(255) NOT NULL)"

class SequelUser < Sequel::Model
  extend Spawner

  validates do
    presence_of :name
  end

  spawner do |user|
    user.name = Faker::Name.name
    user.email = Faker::Internet.email
  end
end

class TestSpawnerWithSequel < Test::Unit::TestCase
  setup do
    @user = SequelUser.spawn :name => "John"
  end

  context "spawned user" do
    should "have John as name" do
      assert_equal "John", @user.name
    end

    context "with invalid attributes" do
      should "raise an error" do
        assert_raise Sequel::Error::InvalidValue do
          SequelUser.spawn :name => nil
        end
      end
    end
  end
end
