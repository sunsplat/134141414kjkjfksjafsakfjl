class Weapon
  attr_accessor :bot
  attr_reader :name,
              :damage

  def initialize(name, damage)
    @name = name
    @damage = damage
  end

  def picked_up?
    !!@bot
  end
end

