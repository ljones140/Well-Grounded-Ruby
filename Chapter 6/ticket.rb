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