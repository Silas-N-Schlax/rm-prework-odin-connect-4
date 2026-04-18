require "colorize"
# Player class for game
class Player
  def initialize(color, name = username)
    @name = name
    @color = color
  end

  def username
    print "Please enter your name! ->".yellow
    gets.chomp.chars.slice(0..12).join
  end
end
