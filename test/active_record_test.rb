require "rubygems"
require "active_record"
require "contest"
require File.dirname(__FILE__) + "/../lib/spawner"
require "faker"

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :dbfile  => ":memory:")
ActiveRecord::Schema.define do
  create_table :active_record_users do |table|
      table.column :name, :string
      table.column :email, :string
  end
end

class ActiveRecordUser < ActiveRecord::Base
  extend Spawner

  validates_presence_of :name

  spawner do |user|
    user.name = Faker::Name.name
    user.email = Faker::Internet.email
  end
end

class TestSpawnerWithActiveRecord < Test::Unit::TestCase
  setup do
    @user = ActiveRecordUser.spawn :name => "John"
  end

  context "spawned user" do
    should "have John as name" do
      assert_equal "John", @user.name
    end

    context "with invalid attributes" do
      should "raise an error" do
        assert_raise ActiveRecord::RecordInvalid do
          ActiveRecordUser.spawn :name => nil
        end
      end
    end
  end
end
