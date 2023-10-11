require 'open-uri'
require 'nokogiri'

class ParseIngredients
  attr_reader :site, :result

  Ingredient = Struct.new(:id, :name, :effects)

  DUBLICATIONS = {
    "Повышение искусства лучника" => "Повышение навыка: стрельба",
  }

  def self.call
    new.call
  end

  def initialize
    @site = "https://elderscrolls.fandom.com/ru/wiki/%D0%98%D0%BD%D0%B3%D1%80%D0%B5%D0%B4%D0%B8%D0%B5%D0%BD%D1%82%D1%8B_(Skyrim)"
    @result = []
  end

  def call
    tables.each do |table|
      parse_table(table)
    end

    result
  end

  private

  def parse_table(table)
    table.css("tr").each do |line|
      blocks = line.css("td")
      next if blocks.empty?
      blocks.shift

      name_block = blocks.shift

      name = if !name_block.css("a").first.nil?
        name_block.css("a").first.children.to_s
      else
        name_block.children.first.children.to_s
      end

      id = blocks.shift&.children&.last&.to_s
      effects = blocks.map do |block|
        fix_name(block&.children&.first&.children&.to_s)
      end

      result << Ingredient.new(id, name, effects)
    end
  end

  def fix_name(name)
    name.gsub!("ё", "е")
    name = DUBLICATIONS[name] unless DUBLICATIONS[name].nil?
    name
  end

  def tables
    page.css("table.wikitable")
  end

  def page
    @_page ||= Nokogiri::HTML(URI.open(site))
  end
end
