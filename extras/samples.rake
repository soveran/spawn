# Use this task to generate sample records
# for your database. This code has to be
# customized for each application.
#
# This task is not installed by default. It's
# provided here so you can use it if you find
# it convenient. To use it, move it to the
# lib/tasks directory in your rails install.
namespace(:db) do
  namespace(:samples) do
    desc "Populate the database with sample records."
    task :load => :environment do

      # Default user
      user = User.spawn :login => 'admin'

      # Default blog
      blog = Blog.spawn :title => 'Foo Blog'

      # Blog posts
      20.times do
        post = Post.spawn :user => user

        # Post comments
        5.times do
          Comment.spawn :post => post
        end
      end
    end
  end
end
