require File.dirname(__FILE__) + '/../lib/spawner'

ActiveRecord::Base.send(:extend, Spawner)
