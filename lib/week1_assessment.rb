class Weapon
  attr_reader :name,
              :damage


  def initialize(name, damage)
    @name = name
    @damage = damage
  end
end

class BattleBot
  @@count = 0

  attr_accessor :weapon
  attr_reader :name,
              :health,
              :enemies

  def initialize(name)
    @name = name
    @health = 100
    @enemies = []
    @@count += 1
  end

  def pick_up(weapon)
    @weapon = weapon unless @weapon
  end

  def drop_weapon
    @weapon = nil
  end

  def take_damage(amount)
    @health -= amount
    @@count -= 1 if dead?
    @health
  end

  def attack(enemy)
    if @weapon && enemy.is_a?(BattleBot)
      enemy.take_damage(10)
      enemy.enemies << self unless enemy.enemies.include?(self)
    elsif 
      raise ArgumentError
    end
  end

  def dead?
    @health <= 0
  end

  def self.count
    @@count
  end
end


