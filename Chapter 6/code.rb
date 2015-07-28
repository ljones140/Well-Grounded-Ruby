x = 1
if x < 0
  p "negative"
elsif x > 0
  p "positive"
else
  p "zero"
end

#returns positive

if false
  x = 1
end
p x
#p y

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
