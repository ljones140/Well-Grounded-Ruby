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
  def price=(amount)
  end  
  attr_reader :venue, :date
  attr_accessor :price
  def discount(percent)
    @price = @price * (100 - percent) / 100.0
  end
  def Ticket.most_expensive(*tickets)
    tickets.max_by(&:price)
  end

end



th = Ticket.new("Town Hall", "11/12/13")
cc = Ticket.new("Convention Centre", "10/12/15")
fg = Ticket.new("Fairgrounds", "10/12/15")
# fg = Ticket.new("cheese shop", "10/12/15")
th.price = 12.55
cc.price = 22.00
fg.price = 18.00
highest = Ticket.most_expensive(th,cc,fg)
puts "the highest priced ticket is for #{highest.venue}"
#wrong = fg.most_expensive
puts Ticket::VENUES
venues = Ticket::VENUES
venues << "High School Gym"

puts Ticket::VENUES

=begin
ticket = Ticket.new("Town Centre", "11/12/13")



ticket.price = (63.00)
puts "the ticket costs $#{"%.2f" % ticket.price}."
ticket.price = (72.50)

puts "the ticket costs $#{"%.2f" % ticket.price}."

#cc = Ticket.new("Convention Centre", "12/13/14", 20)
#puts "We've created two tickets"
#cc.discount(20)

#puts "the first is for a #{th.venue} event on #{th.date}"
#puts "the second is for a #{cc.venue} event on #{cc.date}"
=end
class C
end
class D < C
end
puts C.superclass
puts D.superclass.superclass


puts Object.superclass

c = Class.new do
  def say_hello
    puts "Hello!"
  end
end

c.new.say_hello

puts Class.superclass 


