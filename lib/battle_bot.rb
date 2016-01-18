require_relative 'weapon'

class BattleBot
	attr_accessor :name, :health, :enemies, :weapon
	
	@@count = 0

	def initialize(name)
		raise ArgumentError if name == nil
		@name = name.to_s
		@health = 100
		@enemies = []
		@weapon = nil
		dead?
		has_weapon?
		@@count += 1
	end

	def self.count
		@@count
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
		weapon.bot = self unless @weapon
		@weapon = weapon unless @weapon
	end

	def drop_weapon
		@weapon.bot = nil
		@weapon = nil
	end

	def attack(enemy)
		raise ArgumentError unless enemy.is_a?(BattleBot)
		raise ArgumentError if enemy.name == @name
		raise ArgumentError unless has_weapon?
		enemy.receive_attack_from(self)
	end

	def receive_attack_from(enemy)
		raise ArgumentError unless enemy.is_a?(BattleBot)
		raise ArgumentError if enemy.name == @name
		raise ArgumentError if !enemy.weapon
		take_damage(enemy.weapon.damage)
		@enemies << enemy unless @enemies.include?(enemy)
		defend_against(enemy)
	end

	def defend_against(enemy)
		unless dead?
			if has_weapon?
				attack(enemy)
			end
		end
	end

	def take_damage(damage)
		if !damage.is_a?(Fixnum)
			raise ArgumentError
		else
			if @health > damage 
				@health -= damage
			else
				@@count -= 1
				return @health = 0
			end
		end
	end

	def heal 
		return @health if dead?
		return @health += 10 unless @health > 91
	end

	def dead?
		return true if @health == 0
		return false if @health > 0
	end

	def has_weapon?
		@weapon ? true : false
	end
end