ticket = Object.new

def ticket.date
  "01/02/03"
end
def ticket.venue
  "Town Hall"
end
def ticket.event
  "Author's Reading"
end
def ticket.performer
  "Mark Twain"
end
def ticket.seat
  "Second Balcony, row J, seat 12"
end
def ticket.price
  5.50
end
def ticket.available?
  false
end

print "This ticket is for: "
print ticket.event + ", "

#p Object.new.methods.sort

str = "A String"

puts str.object_id

a = Object.new
b = a
puts "a's objectid is #{a.object_id} and b's objectid is #{b.object_id}"

string_1 = "Hello"
string_2 = "Hello"
puts "sting_1 object id is #{string_1.object_id}"
puts "sting_2 object id is #{string_2.object_id}"


obj = Object.new
if obj.respond_to?("talk")
  obj.talk
else
  puts "sorry this object does not know how to talk"
end


def obj.multi_args(*c)
  p c
end

obj.multi_args(1,2,3,4,5)

def default_args(a,b,c=1)
  puts "Values of variables: ",a,b,c
end

default_args(4,2)

def mixed_args(a,b,*c,d)
  puts "Arguments:"
  p a,b,c,d
end
mixed_args(1,2,3,4,5)

def args_unleashed(a,b=1,*c,d,e)
  puts "Arguments unleashed:"
  p a, b, c, d, e
end

args_unleashed(1,2,3,4,5)
args_unleashed(1,2,3,4)
args_unleashed(1,2,3)
args_unleashed(1,2,3,4,5,6,7,8)
#args_unleashed(1,2) WILL fail


str = "Hello"
abc = str
str.replace("Goodbye")
puts str
puts abc
def say_goodbye
  str = "Hello"
  abc = str
  str.replace("Goodbye")
  puts str
  puts abc
end
say_goodbye

str = "Hello"
abc = str
str = "Goodbye"
puts str
puts abc

def change_string(str)
  str.replace("New string content!")
end

s = "Original String"
#s.freeze
change_string(s)

puts s


def change_string(str)
  str.replace("New string content!")
end

s = "Original String"
change_string(s.dup)

puts s

