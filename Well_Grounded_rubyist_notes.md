
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

** object_id

** respond_to?

** send (synonym:__send__)

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
def obj.multi_args(**x)
  p x
end

obj.multi_args(1,2,3,4,5)
```
```
def obj.multi_args(a,b,**c)
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
def mixed_args(a,b,**c,d)
  puts "Arguments:"
  p a,b,c,d
end
```
mixed_args(1,2,3,4,5) Returns 1, 2, [3,4] , 5

**sponge/splat paramenters get the lowest priority. If method runs out of parameters after the requred parameters are filled the **c gets nothing and is returned as an empty array.

Args Unleashed:

```
def args_unleashed(a,b=1,**c,d,e)
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
  can only have one (**x) per list.
  a default agrument can never go on the right of a ** argument. This is illegal (a,**b,c=1)

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
def Ticket.most_expensive(**tickets)
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

****Method Look up****

When an object is sent a message which is a method the lookup of that message will go up the heierachy of classes and mixins(method-lookup path) the object has until it finds the message or not. method_missing is default error method if no method found.

All objects superclass is Object and object has the module Kernel.
BasicObject is the ancestor for all objects

****Defining same method > 1****

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

****prepend**** however is different. object lookup path checks prepend first even in method is defined in object

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

****super****

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


def o.method_missing(m,**args)
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


Chapter 5 Default object (self) scope and visibility
--------------


Self the current/default object
-----------------------

Only one object is self at any point while a ruby program runs.
Self is determented by what context you're in.

Any code outside of blocks man built in top-level default.

in class or module the module or class object

in method in class: instance of class responding to method name.

in method in module: object extended by module or instance of class that mixes in module

singleton Obj. Obj

puts self outside of a class or methos will return 'main'
main is a special term that default self object uses to refer to itself


inside class, methods modules
-----------------------------

in Class or Module definitions 'self' is the call or module object

if moudule is nested in a class that the self for the module is Class::Module

Instance method definition
--------------------------

when method is called 'self' will be the object that called it. The receiver of the message.

call to self from instance method will give class and memory-location reference:
self is #<C:0x007fbe0b895af0>

Singleton method and class definitions
---------
```
Inside singleton mehtod of #<Object:0x007fd84c833de0>
that was a call to show_me from #<Object:0x007fd84c833de0>
```

It is advantages in class methods to use self as the name of the object calling the method. You can also use the class name but if you chaneg the name you have to change the calls. Self works with any changes.

self as default receiver
----------------------

if receiver of a method is self you can ommit the dot on self.method
if there is a variable with same name as the mehtod the variable takes precedence

Most common use is calling one instance of a method from another

```
Class C
  def X
    some stuff
  end
  def y
    some stuff
    x  #if y is called then x is called from this line
  end
end
```

One case where you have to be explicit with self if the method is a setter method

```
self.venue = "shoebox"
```
if no self you are setting the variable venue rather than calling the mehod

example of using method name without self to neated code:

```
class Person
  attr_accessor :first_name, :middle_name, :last_name
  def whole_name
    n = first_name + " "
    n << "#{middle_name} " if middle_name
    n << last_name
  end
end
```
the **_name methods are called without self.. this makes code easier to read


Resolvinv vaiables through self.
inside different objects methods have their own definition. seperate from others
@v in the example below is only set once. the @v in the method is nil
```
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
  e
```
Returns:

Just inside call def block here's self
C
and here is the instance variable @v belonging to C
"I am an instance variable at top level class body"
Inside an intance method defition block here's self
#<C:0x007fe2ca1aaef0>
and here is the instance variable @v belonging to #<C:0x007fe2ca1aaef0>
nil

Scope
-----

Global variables accessable anywhere. They walk though walls start with $
$gvar

Ruby comes with a large number of pre-defined global variables.

Rarely good to make your own global variables

Local scope
-----------

At any given moment program is in a local scope. Scope changes as you cross between top-level, class or module and methods.

Variables set within these boundaries are seperate. Even if same name.

```
class C
  a = 10
  def some_method
    a = 20
  end
end
```
"a" above is the name of two different variables in different scopes.

Code in class and module definition blocks get executed when encountered. Methods are not executed until an object is sent appropriate message.


```
class C
  def x(value_for_a, recurse=false)
    a = value_for_a
    print " here's inspect string for self"
    p self
    puts "and here is a:"
    puts a
    if recurse
      puts "Calling myself(recursion).."
      x("second value for a")
      puts "Back after recursion"
      puts a
    end
  end
end

c = C.new
c.x("first value fo a", true)
```

returns
 here's inspect string for self#<C:0x007ff103122068>
and here is a:
first value fo a
Calling myself(recursion)..
 here's inspect string for self#<C:0x007ff103122068>
and here is a:
second value for a
Back after recursion
first value fo a


Scope and resolution of constants
---------------------------------

Constants resolved by walking tree of class and modules using ::

Constants are vars in capitals. Constant lookup similar to file/directory lookup. bear in mind when looking up constants from inside parts of the path. Walk the tree from the branch you are on.

```
puts M::C::D::N::X
```

constants are not to be scared of such as Global Variables as even though accessable form anywhere usign the above method they are still in theor scope. Constant X above does not have the same meaning as $x. X is still in it's own scope.

Class variables syntax, scope and visibility
----------------------------------------

class variable example @@var

Class variables are shared between a class and instances of the class. Not visible to anyone else.

See car class exampe in Chapter 5/code.rb

Also class variables are not like contants and will be overwritten.

```
class Parent
  @@var = 100
end

Class Child < Parent
  @@var = 200
end

Class Parent
  puts @@var
end
```
returned @@var is 200 overwitten by the Child

Class variables are not always useful becuase of this so it is beneficial to use Class instance variables.
Classes are objects and have their own instances as do the intances of the objects fromt he class.

See car example in code.rb and the total_count

```
def self.total_count        #this has been added so that when initialize 1st called total_count = 0 (
    @total_count ||= 0        #subsquuent calls it will return value.
  end
  def self.total_count=(n)    #this is the setter for total count. being called as a class instance
    @total_count = n
  end
```

Method access Rules
-------------------

All messages sent to methods unless explicit are Public.

Private Methods
---------------

Private methods can be written
```
private :pour_flour, :add_egg, :stir_batter
```
or just private and the methods you define below will be private.

Private methods cannot be called outside  objects.

You can only call them on self and only without an explicit receiver. Therefore only to be called inside the objects classes etc

Private setter methods are expcetions to the rule but can only be called by the word self. Not the actual self

```
Class dog
  att_reader :age, :dog_years
  def dog_years=(years)
    @dogyears = years
  end
  def age=(years)
    @age = years
    self.dog_years = years ** 7 #this must be self dog = self then dog used will not work
  end
  private :dog_years
end
```
Protected Methods
--------------------

They are similar to private but does allow you to call a protected method on an object x as longs as te self is an instance of the same class as x or an ancester or decendant class of x's class/

Top level methods
------------------

Writing simple scripts outside of classes or modules. Methods are a private instance methid of the object class.

These follow the same rules as only being able to be called on self without an explicit receiver but think about it becuase that is what you do with these types of scripts.

```
def talks
  puts "Hello"
end
```

is the same as:

```
class Object
  private
  def talks
    puts "Hello"
  end
end
```

Chapter 6 Control-flow Technique
---------


Conditional code execution
---------------------------

Two most important code execution techniques are ****if**** and ****case**** statements

**if keyword and friends**

```
if condition
  # code here
end
```

can also put on one line

```
if x > 10 then puts x end
```

can put semicolons to mimic line breaks

```
if x > 10; puts x; end
```

else and elseif can also be used

**Negative conditions with not and !**



```
if not (x==1)
```
This does not require parenthesis

can also use ! (exclamation mark or bang)


```
if ! (x==1)
```
parenthesis needed otherwise would be comparing negative x with 1

Should always use parenthesis when building these constructs

**Unless Keyword**

more natural

```
unless x == y
```

Useful but be aware can be hard to understand if using with else where it gets flipped around. Try not to use with else. flip the condition and use if instead.

**Conditional Modifiers**

```
puts "Big number!" if x > 100
```

same as

```
if x > 100
  puts "Big number!"
end
```

could also use

```
puts "Big number!" unless x <= 100
```

Good to sue for sho simple statements. Try not to use for long statements.

**The Value of Statements**

```
x = 1
if x < 0
  p "negative"
elsif x > 0
  p "positive"
else
  p "zero"
end
```

returns "positive" as elsif is triggered. if not part of an if statement is triggered ruby returns nil.

**Local variable assignment in conditional body**

```
if false
  x = 1
end
p x #returns nil
p y #errors as not in memory
```

when ruby sees x = 1 it assigns x in memory even though in statement above the x = 1 should not be executed. Parser scours code for all possible local variables. Parser does not care that x is never assigned it sees the assignment and makes space in memory. x is in variable limbo it has been initalized with to nil. y gives fatal error as it does nt exist at all.

None of this happens with class, instance or global variables.

**Assignment in conditional test**

when using
```
if x = 1
  puts "hi"
end
```

ruby will send warning as it loos like you should have used ==. No need for a programmer ever to write assignment on x = 1. Test expresstion will always succeed.

Can be useful to do assigning and testing at the same time

```
name = "David A. Black"
if m = /la/.match(name)
  puts "Found a match"
  print "Here's the unmatched start of a string: "
  puts m.pre_match
  print "Heres the unmatched part of a string: "
  puts m.post_match
else
  puts "no match"
end
```

Assignment is made to m as part of the regex match
could have set m before the if.

**Case Statements**

similar to SQL

```
case answer
  when "Yes"
    puts "goodbye"
    exit
  when "no"
    puts "ok"
    else
  puts "whatever"
end
```

can have more than one possible match. comma deliminate. like an or operator.

```
case answer
when "y", "Yes"
  puts
 .....
 ```

 **Threequal operator**

 Case statement above can be rewritten using the === operator

```
if "yes" === answer
  puts "Good-bye!"
  exit
elseif "no" === answer
  puts "OK, we'll continue"
else
  puts "whatever"
end
```

Case statements do use the threequal when when is called.

when you ask a string to threequa against another string it compares each character one by one to the other string.

case/when is === in disguise.

you can define threequal method how you with for your own classes you can exercise contrl over the way your objects behave inside case statements.

```
class Ticket

  attr_accessor :venue, :date

  def initialize venue, date
    self.venue = venue
    self.date = date
  end

  def === (other_ticket)
    self.venue == other_ticket.venue
  end
end

ticket1 = Ticket.new("Town Hall", "07/08/13")
ticket2 = Ticket.new("conference", "07/08/13")
ticket3 = Ticket.new("Town Hall", "07/08/13")

puts "ticket 1 is for ann event at #{ticket1.venue}"

case ticket1
when ticket2
  puts "same location as ticket 2"
when ticket3
  puts "same location as ticket 3"
else
  puts "no match"
end
```

In example above the === method is being defined to compare self.venue with other_ticket.venue. The when in the case statement triggers teh threequal comparing venues.

Case statements can also be written with case on its own and no arguments, the truthful when clause will be executed.


```
case
when user.name == "Lewis"
 puts "hello Lewis"
when Time.now.wday = 5
  puts "it's Friday"
else
  puts "bye"
end
```

The return of case statements is the winning clause or the else. If no else and no when wins then the return is nil.


could write above like


```
puts case
  when user.name == "Lewis"
    "hello Lewis"
  when Time.now.wday = 5
    "it's Friday"
  else
    "bye"
  end
```


> Written with [StackEdit](https://stackedit.io/).



