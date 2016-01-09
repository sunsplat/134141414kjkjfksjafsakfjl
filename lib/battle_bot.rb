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
    raise ArgumentError if weapon.bot
    unless @weapon
      @weapon = weapon
      @weapon.bot = self
      @weapon
    end
  end

  def drop_weapon
    @weapon.bot = nil
    @weapon = nil
  end

  def take_damage(amount)
    @health -= amount
    @health = 0 if @health < 0
    @@count -= 1 if dead?
    @health
  end

  def heal
    @health += 10 unless dead?
    @health = 100 if @health > 100
    @health
  end

  def attack(enemy)
    raise ArgumentError unless @weapon && enemy.is_a?(BattleBot)
    enemy.take_damage(@weapon.damage)
    add_enemy(enemy)
    enemy.attack(self) unless enemy.dead? || !enemy.has_weapon?
  end

  def has_weapon?
    !!@weapon
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

