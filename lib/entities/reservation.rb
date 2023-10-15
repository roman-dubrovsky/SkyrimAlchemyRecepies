# frozen_string_literal: true

class Reservation
  attr_reader :name, :count

  def initialize(name, count)
    @name = name
    @count = count
  end

  def any?
    !@count.zero?
  end

  def print
    puts "#{name}: #{potions_count}"

    @potions.each do |potion|
      puts potion.print(:reserved)
    end
  end

  def reserve_potions(potions)
    available_potions = find_potions(potions)
    left = count

    @potions = []

    while left.positive? && available_potions.any?
      current_potion = available_potions.shift
      next unless current_potion.count.positive?

      current_count = [current_potion.count, left].min
      left -= current_count
      reserve_potion(potions, current_potion, current_count)
    end
  end

  private

  def reserve_potion(potions, current_potion, current_count)
    current_potion.reserve!(current_count)
    potions.recalculate!

    @potions << current_potion
  end

  def potions_count
    @potions.map(&:reverved_count).sum
  end

  def find_potions(potions)
    @potions = potions.find_by_effects([name])
  end
end
