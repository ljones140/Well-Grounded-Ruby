class Temperature
  def Temperature.c2f(celcius) 
    celcius * 9.0 / 5 + 32
  end
  def self.f2c(fahrenheit)
    (fahrenheit - 32) * 5 
  end
end

#self and Temperature are the same thing

puts Temperature.c2f(100)

puts Temperature.f2c(100)

