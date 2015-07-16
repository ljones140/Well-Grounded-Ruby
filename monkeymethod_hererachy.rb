module A
  def monkey_method
    puts "cocoa pops"
  end
end

module B
  def monkey_method
    puts "bananas"
    super
  end
end

class Monkey
  include A
  include B
  #def monkey_method
  #  puts "nuts!!!"
 # end
end

bubbles = Monkey.new
bubbles.monkey_method

p Monkey.ancestors


o.massage