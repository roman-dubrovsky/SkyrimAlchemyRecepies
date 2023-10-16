# frozen_string_literal: true

class PotionsRepository
  attr_reader :potions, :ordering

  def initialize(potions)
    @potions = potions
    reorder_potions(:effects_price)
  end

  def shift
    potions.shift
  end

  def shift_by_price_and_count
  end

  def any?
    potions.any?
  end

  def find_by_effects(effects)
    potions.select { |potion| potion.effects == effects }
  end

  def reorder_potions(order)
    return if @ordering == order

    @ordering = order
    @potions = potions.sort_by(&order).reverse
  end

  def recalculate!
    potions.each(&:recalculate_count)
    @potions = potions.select { |potion| potion.count.positive? }
    force_reorder! if @ordering == :effects_price_with_count
  end

  private

  def force_reorder!
    @potions = potions.sort_by(&@ordering).reverse
  end
end
