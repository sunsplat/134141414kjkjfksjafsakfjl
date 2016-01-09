class Weapon
  # bot is read and write
  # holds reference to bot
  # that picked up weapon
  attr_accessor :bot

  # name and damage
  # are read only
  attr_reader :name,
              :damage

  def initialize(name, damage)
    @name = name
    @damage = damage
  end

  # returns true if currently
  # picked up by bot
  def picked_up?
    !!@bot
  end
end

