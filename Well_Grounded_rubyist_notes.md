
Well Grounded rubyist notes
=======================

Chapter 1
---------

Using IRB
---------

irb --simple-prompt : gives clean input with no version

irb --simple-prompt --noecho : removes the assignment expression. is the nil after a puts



Chapter 2
---------

Objects
-------

Object.new will create a blank object

objects are created with soem methods automaticall. 

p Object.new.methods.sort (sort is just to look nice on screen)

important ones:

* object_id

* respond_to?

* send (synonym:__send__)

each object has an ID
The below will give ID

```
str = "A String"
puts str.object_id
```
This is useful if you need to determine if an object isn teh same as another object or a different object

respond_to?

```
obj = Object.new
if obj.respond_to?("talk")
  obj.talk
else
  puts "sorry this object does not know how to talk"
end
```
multi arguments:
```
def obj.multi_args(*x)
  p x
end

obj.multi_args(1,2,3,4,5)
```
```
def obj.multi_args(a,b,*c)
  p c
end

obj.multi_args(1,2,3,4,5)
```
default argument if c is not send to object below c = 1
```
def default_args(a,b,c=1)
  puts "Values of variables: ",a,b,c
end
```
Mixture of args
```
def mixed_args(a,b,*c,d)
  puts "Arguments:"
  p a,b,c,d
end
```
mixed_args(1,2,3,4,5) Returns 1, 2, [3,4] , 5

*sponge/splat paramenters get the lowest priority. If method runs out of parameters after the requred parameters are filled the *c gets nothing and is returned as an empty array.

Args Unleashed:

```
def args_unleashed(a,b=1,*c,d,e)
  puts "Arguments unleashed:"
  p a, b, c, d, e
end

args_unleashed(1,2,3,4,5)
args_unleashed(1,2,3,4)
args_unleashed(1,2,3)
args_unleashed(1,2,3,4,5,6,7,8)

args_unleashed(1,2) #WILL fail
```
Rules: 
  can only have one (*x) per list. 
  a default agrument can never go on the right of a * argument. This is illegal (a,*b,c=1) 

Variables
---------

variables with exception of variables against integers don't hold values, rather they hold the reference to an object.


```
str = "Hello"
abc = str
str.replace("Goodbye")
puts str
puts abc
```
will return
Goodbye
Goodbye

However if you assign the original variable using = it creates different results
```
str = "Hello"
abc = str
str = "Goodbye"
puts str
puts abc
```
will return
Goodbye
Hello

This is because everythine you assign the variable using = a new assignment to str is made. str and abc part company.


Freezing and duping

```
def change_string(str)
  str.replace("New string content!")
end

s = "Original String"
s.freeze
change_string(s)

puts s
```
String is frozen so returns Can't modify error

```
s = "Original String"
change_string(s.dup)

puts s
```
stripng duped so returns hello

Frozen variables may also be cloned and the freeze stays. duping frozen vars the dupe is not frozen

You can freeze an array stopping the variables from being assign BUT you can use .replace and it will work. A reference to a collections is not hte same as a reference to an object inside a collection.


Chapter 3: Organising Objects with classes
-------------------------------------------

class starts with Capital letter is a constant. 

when you define a object method outside of a class that is a singleton method.
class instance objects can be overwritten (and so can singletons). When  you overide method new version takes precedence

classes can be reponed and methods and new method definitions can be added.

Only open classes with good reason as it makes code hard to follow.

sprint f https://blog.udemy.com/ruby-sprintf/

Variable setter methods
```
def set_price(amount)
   @price = amount
end
```
is equivilent to 
```
def price=(amount)
    @price = amount
end
```
however when you define with = you need to write: ticket.price = (63.00)
AND remember you still need below definition
def price
  @price 
end
```
attr_reader and attr_writer
```
this is:
```
attr_reader :venue, :date, :price
```

equivalent code:
```
  def price
    @price 
  end
  def venue
    @venue
  end
  def date
    @date
  end
```
This:
``` 
 attr_writer :price
```
equivilent code: 
```
def price=(amount)
    @price = amount
end
```

attr_accessor : does both reading and writing

or ```attr :element, true ```
but accessor is clearer and can take mulpitple objects where attr can only take one

Inheretence 
--------------
```
class Publication
  attr_accessor :publisher
end
class Magazine  < Publication #shows casade down from publisher. inherets objects and methods
  attr_accessor :editor
end
```
Ruby classes can only inheret from one class. Unlike other languages that allow multiple class inheretence. Ruby has other features such as modules which are later in book.

Object ancestory
----------------

every object inherets in some way from the class object
```
class C
end
class D < C
end
puts C.superclass #leads to Object
puts D.superclass.superclass #leads to Object
```
Objects superclass is BasicObject

Classes are also objects and classes

Class methods:  

With ticket for example we can have a class method which is a method called on the class not a instance of a call
```
def Ticket.most_expensive(*tickets)
  tickets.max_by(&:price)
end
```
this gets called with :

```
th = Ticket.new("Town Hall", "11/12/13")
cc = Ticket.new("Convention Centre", "10/12/15")
fg = Ticket.new("Fairgrounds", "10/12/15")
th.price = 12.55
cc.price = 22.00
fg.price = 18.00
highest = Ticket.most_expensive(th,cc,fg) #Here the singleton class method is called on the class not an instance.
puts "the highest priced ticket is for #{highest.venue}"
```

Cannot call most_expensive on an instance of the class. even if the code for most expensive is inside the class as it is Ticket.most_expensive it is a class method not a instance method.

Outsise of code to talk about class or instance method

Ticket#price : #hash used to indicate instance method

Ticket::most_expensive or Ticket.most_expensive: . or :: used to talk about class method

Constants
---------

Constants defined starting with capital letter but typically ALL CAPITAL

example:
```
class Ticket
  VENUES = ["Town Hall", "Convention Centre", "Fairgrounds"]
  def initialize(venue,date)
    if VENUES.include?(venue)
      @venue = venue
    else 
      raise ArgumentError, "Unknown venue #{venue}"
    end
    @date = date
  end
```
VENUES is a constant which will produce error if an allowed venue is not added as a parameter.
 
Access the constant outside of the class with :: Ticket::VENUES  

It is not good practice to change a constant and you will get a warning if you try but you can modify the object to which the constant refers. For example
```
venues = Ticket::VENUES
venues << "High School Gym"
```
this adds High School Gym to the venue list as you are appending the array the constant is reverencing 


Chapter 4 Modules
---------- 

Modules are bundles of methods and constants

Module gets include or prepend (prepend ony ruby 2 +) ed onto classes for the class to use the methods within
```
module MyFirstModule
  def say_hello
    puts "hello"
  end
end
```
```
class ModuleTester
  include MyFirstModule
end

mt = ModuleTester.new
mt.say_hello
```
called mix-in

or equals operator:
```
 @stack ||= []
 stack equals a [] if false or nil
```

stacklike.rb:
```
module Stacklike
  def stack
    @stack ||= []
  end
  def add_to_stack(obj)
    stack.push(obj)
  end
  def take_from_stack
    stack.pop
  end
end
```

stack.rb contains the class

```
require_relative "stacklike" #file stacklike required
class Stack
  include Stacklike #includes the stacklike module from stacklike.rb
end
```

Diff require and include: 
Require/load takes a string (loading from disk space)
include/prepend takes the name of the module in form of a Constant (in memory operation)

two operations go together but are seperate from each other. 

Typical but not mandatory to name classes as nouns and modules as adjectives

Modules usefull as you can give class methods to different classses by using require and include. 
Can remove repetition from code. 
With cargohold.rb example the Stacklike module is used but method names changed in Cargohold class


```
class Cargohold
  include Stacklike
  def load_and_report(obj)
    print "Loading object "
    puts obj.object_id

    add_to_stack(obj)
  end
  def unload
    take_from_stack
  end
end
```

**Method Look up**

When an object is sent a message which is a method the lookup of that message will go up the heierachy of classes and mixins(method-lookup path) the object has until it finds the message or not. method_missing is default error method if no method found.

All objects superclass is Object and object has the module Kernel.
BasicObject is the ancestor for all objects

**Defining same method > 1**

If an object receives a message to receive a message but it occurs > 1 in the onbject method-lookup path it will execute the first method of the name it sees.

```
module A
  def monkey_method
    puts "cocoa pops"
  end
end

module B
  def monkey_method
    puts "bananas"
  end
end

class Monkey
  include A
  include B
end

bubbles = Monkey.new
bubbles.monkey_method

```
if monkey_method called Bananas from module B is executed as 1st on lookup list. Even if you add include A again

**prepend** however is different. object lookup path checks prepend first even in method is defined in object

```
class Monkey
  include A
  prepend B
  include A
  def monkey_method
    puts "nuts!!!"
  end
end
```

prepend changes the Monkey.ancestors array
[B, Monkey, A, Object, Kernel, BasicObject]

with B included it is
[Monkey, B, A, Object, Kernel, BasicObject]

**super**

A call to super inside a method. If the method is caled it is executed but whne the code sees super it carries on and finds the higher method and calls that. Calling parts from 2 methods or more.
Allows appending to methods in classes or modules to stop repetiton.
super also passes arguments given/or not given up to it's ancestors

```
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
end
```

Can intercept missing methods with yor own object
```
o = Object.new


def o.method_missing(m,*args)
  puts "you can't call #{m} on this object"
end
```

personclass.rb has a class method for creating a method is method missed is called and the method name and certain creietera are passed.

Design quesstions: Moduels vs classes

Modules cannot be instanced like a class.modules don;t have instance

Class can only have one superclass. A module may benefit if mixing needed but module makes more sense as a other class is a better superclass

Using modules for class name seperation

```
module Tools
  class Hammer
  end
end

h = Tools::Hammer.new
```

This is helpful if you have classes with the same name. Toffee::Hammer Tools::Hammer




> Written with [StackEdit](https://stackedit.io/).



