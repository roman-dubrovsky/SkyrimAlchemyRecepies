# frozen_string_literal: true

require "yaml"

class Config
  FILE_NAME = "output.yml"

  def ingredients
    config_yaml["ingredients"] || {}
  end

  def potions
    config_yaml["potions"] || {}
  end

  def write(potions:, ingredients:)
    yaml_data = {
      "potions" => potions,
      "ingredients" => ingredients,
    }.to_yaml

    File.write(FILE_NAME, yaml_data)
  end

  private

  def config_yaml
    @_config_yaml ||= YAML.load_file(FILE_NAME)
  end
end
