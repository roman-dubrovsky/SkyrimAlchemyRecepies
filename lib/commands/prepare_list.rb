# frozen_string_literal: true

require_relative "../actions/ingredients_list"
require_relative "../actions/make_yml_with_list"

module Commands
  class PrepareList
    def call
      list = Actions::IngredientsList.call
      Actions::MarkYmlWithList.call(list)
    end
  end
end
