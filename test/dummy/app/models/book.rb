class Book < ActiveRecord::Base
  after_destroy :do_something, :do_more

  def do_something
    puts "oh hai something"
  end

  def do_more
    puts "oh hai more"
  end

end
