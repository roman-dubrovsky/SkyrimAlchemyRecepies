#! /usr/bin/env ruby

require_relative "lib/actions/parse_ingredients"
require_relative "lib/actions/make_yml_with_list"

def perform
  list = Actions::ParseIngredients.call

  Actions::MarkYmlWithList.call(list)
end

perform
