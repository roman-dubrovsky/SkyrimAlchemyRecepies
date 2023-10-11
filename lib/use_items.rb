require_relative "combinations"

class UseItems
  attr_reader :list, :ingredients

  def initialize(list:, ingredients:)
    @list = list
    @ingredients = ingredients
  end

  def call
    result = []

    while best_variant = Combinations.new(list: list, ingredients: ingredients).call
      result << best_variant

      best_variant.names.each do |name|
        ingredients[name] -= best_variant.count
      end
    end

    result
  end
end
