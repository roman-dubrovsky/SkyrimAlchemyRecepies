#! /usr/bin/env ruby
# frozen_string_literal: true

require_relative "lib/actions/parse_ingredients"
require_relative "lib/actions/set_ingredients_count"
require_relative "lib/actions/prepare_best_list_for_crafting"

def perform
  list = Actions::ParseIngredients.call

  Actions::SetIngredientsCount.new(list).call

  result = Actions::PrepareBestListForCrafting.new(list).call

  result.each do |potion|
    puts potion.print
  end
end

perform
