obj = Object.new


def obj.talk
  puts "I am an object"
  puts "(Do you object?)"
end

def obj.c2f(c)
  c * 9.0 / 5 + 32
end

def blocker(arr, &block)
  block(arr) 
end


obj.talk        

puts obj.c2f(100)

puts "yes" if obj.respond_to?(:talk)

puts "yes" if {1 => 3}.respond_to?(:map)

#monkey_lambda = lambda  {|x| x.length > 2 ? x = "monkey" : x}

animals = ["cat", "dog", "zebra", "ant", "Chicken"]

#puts blocker(animals, monkey_lambda)



