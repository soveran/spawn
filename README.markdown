Spawner
=======

A ridiculously simple fixtures replacement for your web framework of
choice.

Description
-----------

Spawner is a very small library (just 15 lines of code) that can
effectively replace fixtures or any other huge library for the same task.

Usage
-----

In the examples below we are using [Faker](http://faker.rubyforge.org/)
to generate random data, but you can use any method.

With ActiveRecord:

    class User < ActiveRecord::Base
      spawner do |user|
        user.name = Faker::Name.name
        user.email = Faker::Internet.email
      end
    end

With Sequel:

    class User < Sequel::Model
      extend Spawner

      spawner do |user|
        user.name = Faker::Name.name
        user.email = Faker::Internet.email
      end
    end

If you don't want to pollute your class definition, you
can of course use it from outside:

    User.spawner do |user|
      user.name = Faker::Name.name
      user.email = Faker::Internet.email
    end

Then, in your test or in any other place:

    @user = User.spawn

Or, if you need something special:

    @user = User.spawn do |user|
      user.name = "Michel Martens"
    end

Or even this:

    @user = User.spawn :name => "Michel Martens"

Installation
------------

    $ gem sources -a http://gems.github.com (you only have to do this once)
    $ sudo gem install soveran-spawner

### Thanks

Thanks to Foca (http://github.com/foca/) for his suggestions and Pedro
(http://github.com/peterpunk/) for the gemspec.

License
-------

Copyright (c) 2009 Michel Martens for Citrusbyte

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
