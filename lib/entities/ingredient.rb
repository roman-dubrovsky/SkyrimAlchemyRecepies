class Ingredient
  attr_reader :name, :effects, :count, :potions

  def initialize(name, effects)
    @name = name
    @effects = effects
    @count = 0
    @potions = []
  end

  def count=(count)
    @count = count
  end

  def use(used_count)
    @count -= used_count
    potions.each(&:recalculate_count)
  end

  def add_potion(potion)
    potions << potion
  end
end
