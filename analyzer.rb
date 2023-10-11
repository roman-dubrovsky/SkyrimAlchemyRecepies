#! /usr/bin/env ruby

require 'yaml'

require_relative "lib/parse_ingredients"
require_relative "lib/shared"

require_relative "lib/use_items"

def perform
  list = ParseIngredients.call

  ingredients = YAML.load_file(Shared::FILE_NAME)

  result = UseItems.new(list: list, ingredients: ingredients).call

  result.each do |item|
    puts "#{item.names} - #{item.effects} - #{item.count} - cost: #{item.effects_count}"
  end
end

perform
