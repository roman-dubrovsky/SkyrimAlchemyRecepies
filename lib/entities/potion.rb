# frozen_string_literal: true

require_relative "../shared"

class Potion
  attr_reader :effects, :ingredient1, :ingredient2, :ingredient3, :count, :resolved_count, :reverved_count

  def initialize(effects, ingredient1, ingredient2, ingredient3 = nil)
    @effects = effects
    @ingredient1 = ingredient1
    @ingredient2 = ingredient2
    @ingredient3 = ingredient3
    @resolved_count = nil
    @reverved_count = nil

    recalculate_count
  end

  def effects_price
    @_effects_price ||= effects.map { |effect| Shared::EFFECTS_COST[effect] }.sum
  end

  def recalculate_count
    @count = ingredients.map(&:count).min
  end

  def reserve!(count)
    @reverved_count = count
    use(count)
  end

  def pin_potion
    @resolved_count = count
    use(count)
  end

  def print(count_type = nil)
    displayed_count = count_type == :reserved ? reverved_count : resolved_count
    "#{ingredients.map(&:name).sort} - #{effects} - #{displayed_count} - price: #{effects_price}"
  end

  private

  def use(count)
    ingredients.each { |ingredient| ingredient.use(count) }
  end

  def ingredients
    [ingredient1, ingredient2, ingredient3].compact
  end
end
