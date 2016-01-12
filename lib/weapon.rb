class Weapon
  # bot is read and write
  # holds reference to bot
  # that picked up weapon
  attr_accessor :bot

  # name and damage
  # are read only
  attr_reader :name,
              :damage

  def initialize(name, damage=10)
    raise ArgumentError unless name.is_a?(String)
    raise ArgumentError unless damage.is_a?(Fixnum)
    @name = name
    @damage = damage
  end


  # Sets the bot attribute and
  # raises ArgumentError if value is not
  # a BattleBot
  def bot=(bot)
    unless bot.is_a?(BattleBot) ||
           bot.nil?
      raise ArgumentError
    end
    @bot = bot
  end


  # returns true if currently
  # picked up by bot
  def picked_up?
    !!@bot
  end
end

