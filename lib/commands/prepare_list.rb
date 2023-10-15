# frozen_string_literal: true

require_relative "../actions/parse_ingredients"
require_relative "../actions/make_yml_with_list"

module Commands
  class PrepareList
    def call
      list = Actions::ParseIngredients.call
      Actions::MarkYmlWithList.call(list)
    end
  end
end
