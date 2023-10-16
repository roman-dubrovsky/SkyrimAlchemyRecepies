# frozen_string_literal: true

module Actions
  class ReadYamlConfig
    attr_reader :list, :config

    def initialize(list, config)
      @list = list
      @config = config
    end

    def call
      list.each do |ingredient|
        ingredient.count = ingredients_count[ingredient.name] || 0
      end
    end

    private

    def ingredients_count
      config.ingredients
    end
  end
end
