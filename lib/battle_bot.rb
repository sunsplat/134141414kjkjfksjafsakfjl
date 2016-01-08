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
    raise ArgumentError unless enemy.is_a?(BattleBot)
    raise "No Weapon"  unless @weapon
    enemy.take_damage(@weapon.damage)
    add_enemy(enemy)
  end

  def dead?
    @health <= 0
  end

  def self.count
    @@count
  end

  private
  def add_enemy(enemy)
    enemy.enemies << self unless enemy.enemies.include?(self)
  end
end

