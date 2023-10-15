# frozen_string_literal: true

class Ingredient
  attr_accessor :count
  attr_reader :name, :effects, :potions

  def initialize(name, effects)
    @name = name
    @effects = effects
    @count = 0
    @potions = []
  end

  def use(used_count)
    @count -= used_count
    potions.each(&:recalculate_count)
  end

  def add_potion(potion)
    potions << potion
  end
end
