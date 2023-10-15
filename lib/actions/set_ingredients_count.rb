require_relative "../shared"

module Actions
  class SetIngredientsCount
    attr_reader :list

    def initialize(list)
      @list = list
    end

    def call
      list.each do |ingredient|
        ingredient.count = ingredients_count[ingredient.name] || 0
      end
    end

    private

    def ingredients_count
      @_ingredients_count ||= YAML.load_file(Shared::FILE_NAME)
    end
  end
end
