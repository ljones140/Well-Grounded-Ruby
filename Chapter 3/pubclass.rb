class Publication
  attr_accessor :publisher
end
class Magazine  < Publication
  attr_accessor :editor
end

mag = Magazine.new
mag.publisher = "David A. Black"
mag.editor = "Joe Smith"
puts "Mag is published by #{mag.publisher} and edited by #{mag.editor}"