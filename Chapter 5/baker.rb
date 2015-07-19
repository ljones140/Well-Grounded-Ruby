class Cake
  def initialize(batter)
    @batter = batter
    @baked = true
  end
end
class Egg
end
class Flour
end
class Baker
  def bake_cake
    @batter = []
    pour_flour
    add_egg
    stir_batter
    return Cake.new(@batter)
  end
  def pour_flour
    @batter.push(Flour.new)
  end
  def add_egg
    @batter.push(Egg.new)
  end
  def stir_batter
  end
  private :pour_flour, :add_egg, :stir_batter
end

b = Baker.new
#b.add_egg #not allowed

class Dog
  attr_reader :age, :dog_years
  def dog_years=(years)
    @dog_years = years
  end
  def age=(years)
    @age = years
    self.dog_years = years * 7
  end
  private :dog_years=
end

rover = Dog.new
rover.age = 10
puts "Dog is #{rover.dog_years} old"

