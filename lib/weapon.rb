class Weapon

	def initialize(weapon, damage)
		raise ArgumentError if !damage.is_a?(Fixnum)
		@weapon = weapon
		@name = name
		@damage = damage
		raise ArgumentError if @name == nil
		raise ArgumentError if !@name.is_a?(String)
	end

	def name 
		@name
		raise NoMethodError if @name
	end

	def damage
		@damage
		raise NoMethodError if @damage
	end

	def bot
		nil
		raise ArgumentError if !BattleBot
	end

	def picked_up?
		if pick_up(weapon)
			true
		else
			false
		end
	end

end