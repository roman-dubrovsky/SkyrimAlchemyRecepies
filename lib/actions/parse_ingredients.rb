# frozen_string_literal: true

require "open-uri"
require "nokogiri"

require_relative "../entities/ingredient"

module Actions
  class ParseIngredients
    attr_reader :site, :result

    DUBLICATIONS = {
      "Повышение искусства лучника" => "Повышение навыка: стрельба",
    }.freeze

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
        name = name_for(blocks.shift)
        blocks.shift
        effects = find_effects(blocks)

        result << Ingredient.new(name, effects)
      end
    end

    def find_effects(blocks)
      blocks.map do |block|
        fix_name(block&.children&.first&.children&.to_s)
      end
    end

    def name_for(name_block)
      if name_block.css("a").first.nil?
        name_block.children.first.children.to_s
      else
        name_block.css("a").first.children.to_s
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
end
