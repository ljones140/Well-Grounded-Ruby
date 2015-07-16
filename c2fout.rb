puts "Please eneter Celsius value"
celsius = gets.to_i
fahrenheit = (celsius * 9 / 5) + 32
puts "Saving result to outputfile 'temp.out"
fh = File.new("temp.out", "w")
fh.puts fahrenheit
fh.close