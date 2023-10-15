# frozen_string_literal: true

require_relative "../shared"

class Potion
  attr_reader :effects, :ingredient1, :ingredient2, :ingredient3, :count, :resolved_count

  def initialize(effects, ingredient1, ingredient2, ingredient3 = nil)
    @effects = effects
    @ingredient1 = ingredient1
    @ingredient2 = ingredient2
    @ingredient3 = ingredient3
    @resolved_count = nil

    recalculate_count
    index_potion
  end

  def effects_price
    @_effects_price ||= effects.map { |effect| Shared::EFFECTS_COST[effect] }.sum
  end

  def recalculate_count
    @count = ingredients.map(&:count).min
  end

  def pin_potion
    @resolved_count = count
    ingredient1.use(count)
    ingredient2.use(count)
    ingredient3&.use(count)
  end

  def print
    "#{ingredients.map(&:name).sort} - #{effects} - #{resolved_count} - price: #{effects_price}"
  end

  private

  def index_potion
    ingredient1.add_potion(self)
    ingredient2.add_potion(self)
    ingredient3&.add_potion(self)
  end

  def ingredients
    [ingredient1, ingredient2, ingredient3].compact
  end
end
