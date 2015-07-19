=begin

puts "Top Level"
puts "self is #{self}" #main

class C
  puts "Class definition block:"
  puts "self is #{self}"

  def self.x
    puts "Class method C.x:"
    puts "self is #{self}"
  end

  def m
    puts "instance method C#m:"
    puts "self is #{self}"
  end

end

class D < C
end

D.x

C.x

monkey = C.new
monkey.m
puts "that was a call to m by: #{monkey}"


obj = Object.new
def obj.show_me
  puts "Inside singleton mehtod of #{self}"
end
obj.show_me
puts "that was a call to show_me from #{obj}"

=end

class Person
  attr_accessor :first_name, :middle_name, :last_name
  def whole_name
    n = first_name + " "
    n << "#{middle_name} " if middle_name
    n << last_name
  end
end

lewis = Person.new
lewis.first_name = "lewis"
lewis.last_name = "Jones"
puts "Lewis wholename #{lewis.whole_name}"
lewis.middle_name = "Anthoney"
puts "Lewis wholename #{lewis.whole_name}"


class C
  puts "Just inside call def block here's self"
  p self
  @v = "I am an instance variable at top level class body"
  puts "and here is the instance variable @v belonging to #{self}"
  p @v
  def show_var
    puts "Inside an intance method defition block here's self"
    p self
    puts "and here is the instance variable @v belonging to #{self}"
    p @v
  end
end

#c = C.new
#c.show_var


class C
  def x(value_for_a, recurse=false)
    a = value_for_a
    print " here's inspect string for self: "
   # p self
    puts self.object_id
    puts "and here is a: "
    puts a.object_id
    #puts a
    if recurse
      puts "Calling myself(recursion).."
      x("second value for a")
      puts "Back after recursion"
      #puts a
      puts a.object_id
    end
  end
end

#c = C.new
#c.x("first value fo a", true)


#Class variables example

class Car
  @@makes = []
  @@cars = {}
#  @@total_count = 0
  attr_reader :make
#  def self.total_count        #this has been commented out as it also holds counts for child classes to car
#    @@total_count
#  end
  def self.total_count        #this has been added so that when initialize 1st called total_count = 0 (
    @total_count ||= 0        #subsquuent calls it will return value.
  end
  def self.total_count=(n)    #this is the setter for total count. being called as a class instance variable below
    @total_count = n
  end
  def self.add_make(make)
    unless @@makes.include?(make)
      @@makes << make
      @@cars[make] = 0
    end
  end
  def initialize(make)
    if @@makes.include?(make)
      puts "Creating an new #{make}"
      @make = make
      @@cars[make] += 1
 #     @@total_count += 1
      self.class.total_count += 1      #being called on a class instance variable. not a class variable or an instance variable
    else raise "No such make: #{make}"
    end
  end
  def make_mates
    @@cars[self.make]
  end
end






Car.add_make("Honda")
Car.add_make("Ford")
h = Car.new("Honda")
f = Car.new("Ford")
h2 = Car.new("Honda")

Car.add_make("Tesla")
t = Car.new("Tesla")



puts "there are #{h2.make_mates} cars made by #{h2.make}"
puts "there are #{Car.total_count} cars in total"


class Hybrid < Car
end

h3 = Hybrid.new("Honda")
h3 = Hybrid.new("Ford")
puts "there are #{Hybrid.total_count} Hybrids in total"














