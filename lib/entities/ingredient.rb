# frozen_string_literal: true

class Ingredient
  attr_accessor :count
  attr_reader :name, :effects

  def initialize(name, effects)
    @name = name
    @effects = effects
    @count = 0
  end

  def use(used_count)
    @count -= used_count
  end
end
