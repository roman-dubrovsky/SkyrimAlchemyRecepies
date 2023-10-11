class Combinations
  attr_reader :list, :ingredients

  class Result
    attr_reader :count1, :count2, :count3, :effects
    attr_reader :ingredient1, :ingredient2, :ingredient3

    def initialize(effects, item1, item2, item3 = nil)
      @effects = effects
      @ingredient1, @count1 = item1
      @ingredient2, @count2 = item2
      @ingredient3, @count3 = item3 unless item3.nil?
    end

    def effects_count
      effects.count
    end

    def names
      [ingredient1, ingredient2, ingredient3].compact.map(&:name)
    end

    def count
      @_count ||= begin
        counts_list = [count1, count2]
        counts_list << count3 unless count3.nil?
        counts_list.min
      end
    end
  end

  def initialize(list:, ingredients:)
    @list = list
    @ingredients = ingredients
  end

  def call
    result = []
    count = filterred_items.count

    filterred_items.each.with_index do |pair1, index1|
      item1 = pair1.first
      ((index1 + 1)..(count - 1)).to_a.each do |index2|
        item2 = filterred_items[index2].first

        matches = match_items(item1, item2)

        result << Result.new(matches, filterred_items[index1], filterred_items[index2]) if matches.any?

        ((index2 + 1)..(count - 1)).to_a.each do |index3|
          item3 = filterred_items[index2].first
          matches1_3 = match_items(item1, item3)
          matches2_3 = match_items(item2, item3)
          next if matches1_3.empty? && matches2_3.empty?

          current_matches = matches + matches1_3 + matches2_3
          result << Result.new(current_matches.uniq, filterred_items[index1], filterred_items[index2], filterred_items[index3])
        end
      end
    end

    return nil if result.empty?
    max_count = result.map(&:effects_count).max
    result.select { |item| item.effects_count == max_count}.sort_by(&:count).last
  end

  private

  def match_items(item1, item2)
    item1.effects & item2.effects
  end

  def filterred_items
    pair_item_and_count.reject do |name, count|
      count.zero?
    end
  end

  def pair_item_and_count
    list.map do |item|
      name = item.name
      [item, ingredients[name]]
    end
  end
end
