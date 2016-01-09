class BattleBot
  # global bot instance
  # count
  @@count = 0

  # weapon is read and write
  attr_accessor :weapon

  # name, health, and enemies
  # are read only
  attr_reader :name,
              :health,
              :enemies

  def initialize(name)
    # name is settable through parameter
    @name = name

    # other instance variables are not
    @health = 100
    @enemies = []

    # increment instance count
    # on instantiate
    @@count += 1
  end

  def pick_up(weapon)
    # if weapon is already picked up
    # raise an error
    raise ArgumentError if weapon.bot

    # unless this bot already has a weapon
    # set the weapon
    # set the weapon's bot
    # return the weapon
    unless @weapon
      @weapon = weapon
      @weapon.bot = self
      @weapon
    end
  end

  def drop_weapon
    # nilify weapon's bot first
    # then weapon
    @weapon.bot = nil
    @weapon = nil
  end

  def take_damage(amount)
    # decrement health by damage amount
    @health -= amount

    # if health is less than 0
    # clamp at 0
    @health = 0 if @health < 0

    # decrement global instance count
    @@count -= 1 if dead?

    # return health
    @health
  end

  def heal
    # heal if not dead
    @health += 10 unless dead?

    # clamp health at max health value
    @health = 100 if @health > 100

    # return health
    @health
  end

  def attack(enemy)
    # raise error if bot has no weapon
    # or is trying to attack
    # something that is not a bot
    raise ArgumentError unless @weapon && enemy.is_a?(BattleBot)

    # damage the attacked bot
    enemy.take_damage(@weapon.damage)

    # add the enemy to enemy array
    add_enemy(enemy)

    # call attack on the enemy
    # if it is not dead
    # and it has a weapon
    enemy.attack(self) if !enemy.dead? && enemy.has_weapon?
  end

  def has_weapon?
    # double bang coverts to
    # boolean
    !!@weapon
  end

  def dead?
    # is health positive?
    @health <= 0
  end

  def self.count
    # class var getter
    @@count
  end

  private
  def add_enemy(enemy)
    # add enemy to enemies array
    # only if it is not already in
    # the array
    enemy.enemies << self unless enemy.enemies.include?(self)
  end
end

