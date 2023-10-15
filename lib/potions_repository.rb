# frozen_string_literal: true

class PotionsRepository
  attr_reader :potions

  def initialize(potions)
    @potions = potions.sort_by(&:effects_price).reverse
  end

  def shift
    potions.shift
  end

  def any?
    potions.any?
  end

  def find_by_effects(effects)
    potions.select { |potion| potion.effects == effects }
  end

  def recalculate!
    potions.each(&:recalculate_count)
    @potions = potions.select { |potion| potion.count.positive? }
  end
end
