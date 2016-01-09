require 'spec_helper'
require 'battle_bot'
require 'weapon'

describe BattleBot do


  let(:bot_name) { "FooBot" }
  let(:bot) { BattleBot.new(bot_name) }
  let(:bot2) { BattleBot.new("BarBot") }


  # ------------------------------------
  # #initialize
  # ------------------------------------

  describe '#initialize' do


    it "has a name" do
      expect(bot.name).to eq(bot_name)
    end


    it "begins with 100 health" do
      expect(bot.health).to eq(100)
    end


    it "raises a NoMethodError when attempting to set health" do
      expect { bot.health = 500 }.to raise_error(NoMethodError)
    end


    it "does not have a weapon by default" do
      expect(bot.weapon).to eq(nil)
    end


    it "is not dead" do
      expect(bot.dead?).to eq(false)
    end


    it "does not start with a weapon" do
      expect(bot.has_weapon?).to eq(false)
    end
  end

  # ------------------------------------
  # interactions
  # ------------------------------------

  describe "interactions" do


    let(:weapon){ Weapon.new("FooWeapon", 10) }
    let(:weapon2){ Weapon.new("Better Weapon", 20)}


    it "can pick up a weapon" do
      bot.pick_up weapon
      expect(bot.weapon).to eq(weapon)
    end


    it "cannot pick up a weapon already picked up by another bot" do
      bot.pick_up(weapon)
      expect { bot2.pick_up(weapon) }.to raise_error(ArgumentError)
    end


    context "after picking up a weapon" do
      before do
        bot.pick_up weapon
      end


      it "can drop the weapon" do
        bot.drop_weapon
        expect(bot.weapon).to eq(nil)
      end


      it "cannot pick up another weapon" do
        bot.pick_up weapon2
        expect(bot.weapon).to eq(weapon)
      end


      it "sets the weapon's bot attribute to the bot that picked up the weapon" do
        expect(weapon.bot).to eq(bot)
      end

    end

    # ------------------------------------
    # #count
    # ------------------------------------

    describe '#count' do

      before(:each) do
        BattleBot.class_variable_set(:@@count, 0)
      end


      it 'returns 0 if no bots have been created' do
        expect(BattleBot.count).to eq(0)
      end


      it 'returns 1 if one bot has been created' do
        bot
        expect(BattleBot.count).to eq(1)
      end


      it 'returns 2 if another bot has been created' do
        bot
        bot2
        expect(BattleBot.count).to eq(2)
      end


      it 'returns only the number of LIVING bots' do
        bot
        bot2.take_damage(100)
        expect(BattleBot.count).to eq(1)
      end

    end

    # ------------------------------------
    # doing battle
    # ------------------------------------

    describe "doing battle" do

      context "without a weapon" do

        it "raises an ArgumentError" do
          expect { bot.attack bot2 }.to raise_error(ArgumentError)
        end
      end


      context "with a weapon" do

        before do
          bot.pick_up(weapon)
        end


        it "can attack another Battle Bot" do
          expect { bot.attack bot2 }.to_not raise_error
        end


        it 'cannot attack things that are not Battle Bots' do
          expect { bot.attack [1,2,3]}.to raise_error(ArgumentError)
        end


        context "after attacking another bot" do
          it "deals weapon damage with each attack" do
            expect(bot2).to receive(:take_damage).with(weapon.damage)
            bot.attack bot2
          end
        end


        context "after being attacked" do
          before { bot.attack bot2 }

          it "receives damage" do
            expect(bot2.health).to eq(100 - weapon.damage)
          end


          context "it is not dead" do
            it 'can heal' do
              expect { bot2.heal }.to change(bot2, :health).by(10)
            end


            it 'cannot heal past the maximum health value' do
              20.times { bot2.heal }
              expect(bot2.health).to eq(100)
            end
          end


          context "it is dead" do
            it 'cannot heal' do
              bot2.take_damage(1000)
              expect { bot2.heal }.to change(bot2, :health).by(0)
            end
          end
        end


        context "after receiving damage" do
          it "checks if itself is dead" do
            expect(bot2).to receive(:dead?).at_least(1).times
            bot.attack bot2
          end
        end


        context "the enemy bot is still alive" do
          context "and has a weapon" do
            it "triggers a retaliation attack from the enemy bot on the original bot" do
              bot2.pick_up(weapon2)
              expect(bot2).to receive(:attack).with(bot)
              bot.attack(bot2)
            end
          end


          context "and does not have a weapon" do
            it "does not trigger a retaliation attack from the enemy bot" do
              expect(bot2).to_not receive(:attack)
              bot.attack(bot2)
            end

          end
        end
      end


      context "after receiving significant damage" do
        before do
          bot.take_damage(100)
        end


        it "is dead" do
          expect(bot.dead?).to eq(true)
        end


        context "the damage is greater than the value of health" do
          it "never has goes below zero" do
            bot.take_damage(1000)
            expect(bot.health).to eq(0)
          end

        end
      end
    end

    # ------------------------------------
    # #enemies
    # ------------------------------------

    describe '#enemies' do
      let(:bot3){ BattleBot.new "BazBot"}

      it 'starts returning a blank array' do
        expect(bot.enemies).to eq([])
      end


      it 'returns an array of bots who attacked it' do
        [bot2, bot3].each do |b|
          b.pick_up Weapon.new("laser", 10)
          b.attack(bot)
        end

        expect(bot.enemies).to eq([bot2, bot3])
      end


      it 'does not count the same bot twice' do
        [bot2, bot2, bot3].each do |b|
          b.pick_up Weapon.new("laser", 10)
          b.attack(bot)
        end

        expect(bot.enemies).to eq([bot2, bot3])
      end


      it 'cannot be directly modified' do
        expect(bot).to_not respond_to(:enemies=)
      end

    end
  end
end

