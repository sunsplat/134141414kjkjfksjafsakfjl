class BattleBot
  # global bot instance
  # count
  @@count = 0

  # name, health, enemies, and weapon
  # are read only
  attr_reader :name,
              :health,
              :enemies,
              :weapon

  def initialize(name)
    raise ArgumentError unless name.is_a?(String)

    # name is settable through parameter
    @name = name

    # other instance variables are not
    @health = 100
    @enemies = []

    # increment instance count
    # on instantiate
    @@count += 1
  end


  # Picks up the given weapon
  # only if the bot
  # is able to pick up the weapon
  def pick_up(weapon)
    # raise argument error if
    # the object is not a weapon
    raise ArgumentError unless weapon.is_a?(Weapon)

    # if weapon is already picked up
    # raise an error
    raise ArgumentError if weapon.picked_up?

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


  # Drops the currently
  # picked up weapon
  def drop_weapon
    # nilify weapon's bot first
    # then weapon
    @weapon.bot = nil
    @weapon = nil
  end


  # Damages the bot
  # by the given
  # amount
  def take_damage(amount)
    # raise error unless we have an integer
    raise ArgumentError unless amount.is_a?(Fixnum)

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


  # Heals the bot by
  # 10 unless has full health
  def heal
    # heal if not dead
    @health += 10 unless dead?

    # clamp health at max health value
    @health = 100 if @health > 100

    # return health
    @health
  end


  # Attacks the enemy if it is a bot
  def attack(enemy)
    # Make sure the enemy is a bot
    raise ArgumentError unless enemy.is_a?(BattleBot)

    # Attack the enemy bot
    # pass it this bot
    enemy.receive_attack_from(self)
  end


  # Receives an attack from
  # an enemy bot
  def receive_attack_from(enemy)
    # Make sure the enemy is a bot
    raise ArgumentError unless enemy.is_a?(BattleBot)

    # Make sure enemy passes
    # validations
    validate_attackable(enemy)

    # Damage this bot with the
    # damage amount from the
    # enemy's weapon
    take_damage(enemy.weapon.damage)

    # Add the attacking enemy to
    # the enemies array
    add_enemy(enemy)

    # Trigger defense against attacking bot
    defend_against(enemy)
  end


  # Triggers a defensive
  # attack against the enemy
  def defend_against(enemy)
    attack(enemy) if !dead? && has_weapon?
  end


  # Returns true if the bot
  # has a weapon
  def has_weapon?
    # double bang coverts to
    # boolean
    !!@weapon
  end


  # Returns true if
  # health is positive?
  def dead?
    @health <= 0
  end


  # Class getter for
  # alive instance count
  def self.count
    @@count
  end

  private
  # add enemy to enemies array
  # only if it is not already in
  # the array
  def add_enemy(enemy)
    enemies << enemy unless enemies.include?(enemy)
  end


  # Raise an argument error
  # if trying to self attack,
  # this bot is weaponless
  # or trying to attack something
  # that is not a bot
  def validate_attackable(enemy)
    raise ArgumentError unless enemy != self && enemy.has_weapon?
  end
end

