require_relative 'battle_bot'

class Weapon

	attr_reader :name, :damage
	attr_accessor :bot

	def initialize(weapon, damage = 0)
		@name = weapon.to_s
		@damage = damage
		raise ArgumentError if !weapon.is_a?(String)
		raise ArgumentError if !damage.is_a?(Fixnum)
		@picked_up = false
	end

	def bot=(bot)
		if bot.nil?
			@bot = bot
		else
			raise ArgumentError unless bot.is_a?(BattleBot)
			@bot = bot
		end	
	end

	def picked_up?
		@picked_up
	end

	def pick_up
		@picked_up = true
	end 

end