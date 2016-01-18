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

	def name=(name)
		raise NoMethodError if @name
	end

	def health=(health)
		raise NoMethodError if @health
	end

	def enemies=(enemies)
		raise NoMethodError if @enemies
	end

	def weapon=(weapon)
		raise NoMethodError 
	end

	def pick_up(weapon)
		raise ArgumentError unless weapon.instance_of?(Weapon)
		raise ArgumentError if weapon.picked_up?
		weapon.pick_up
		@weapon = weapon unless @weapon
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
		@weapon ? true : false
	end
end