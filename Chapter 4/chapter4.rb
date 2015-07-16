module MyFirstModule
  def say_hello
    puts "hello"
  end
end

class ModuleTester
  include MyFirstModule
end

mt = ModuleTester.new
mt.say_hello