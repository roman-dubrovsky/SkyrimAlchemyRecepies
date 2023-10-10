#! /usr/bin/env ruby

require_relative "lib/parse_ingredients"
require_relative "lib/make_yml_with_list"

def perform
  list = ParseIngredients.call

  MarkYmlWithList.call(list)
end

perform
