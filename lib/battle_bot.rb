require_relative 'weapon'

class BattleBot
	attr_accessor :name, :health, :enemies, :weapon, :dead, :has_weapon
	
	def initialize(name)
		raise ArgumentError if name == nil
		@name = name.to_s
		@health = 100
		@enemies = []
		@weapon = nil
		dead?
		has_weapon?
	end

	# def enemies
	# 	@enemies
	# 	raise NoMethodError if @enemies
	# end

	# def weapon
	# 	@weapon
	# end

	def pick_up(weapon)
		# raise ArgumentError unless weapon.instance_of?(Weapon.class)

		weapon.pick_up
	end

	def drop_weapon
		@weapon = nil
		@weapon.bot = nil
	end

	def take_damage(damage)
		if !damage.is_a?(Fixnum)
			raise ArgumentError
		else
			if @health > damage 
				@health -= damage
			else
				return @health = 0
			end
		end
	end

	def dead?
		return true if @health == 0
		return false if @health > 0
	end

	def has_weapon?
		@weapon
	end
end