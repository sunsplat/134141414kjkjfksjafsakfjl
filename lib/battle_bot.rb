require_relative 'weapon'

class BattleBot
	attr_accessor :name, :health, :enemies, :weapon, :dead, :has_weapon
	
	def initialize(name)
		raise ArgumentError if name == nil
		@name = name
		@health = 100
		@enemies = []
		@weapon = nil
		dead?
		has_weapon?
	end

	def name
		@name
		raise NoMethodError if name == @name
	end

	def health
		@health
		raise NoMethodError if defined?(@health)
	end

	def enemies
		@enemies
		raise NoMethodError if @enemies
	end

	def weapon
		@weapon
	end

	def pick_up(weapon)
		if weapon
			weapon
		else
			raise ArgumentError
		end
	end

	def drop_weapon
		@weapon = nil
		@name.weapon = nil
	end

	def take_damage(damage)
		if !damage.is_a?(Fixnum)
			raise ArgumentError
		else
			@health -= damage
		end
	end

	def heal
		@health += 10
	end

	def dead?
		@dead = false
	end

	def has_weapon?
		@has_weapon = false
	end
end