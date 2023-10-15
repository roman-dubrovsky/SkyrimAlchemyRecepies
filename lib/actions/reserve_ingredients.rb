# frozen_string_literal: true

require_relative "../entities/reservation"

module Actions
  class ReserveIngredients
    attr_reader :potions, :reserve

    def initialize(potions:, reserve:)
      @potions = potions
      @reserve = reserve
    end

    def call
      reservations.each { |reservation| reservation.reserve_potions(potions) }
      reservations
    end

    private

    def reservations
      @_reservations ||= reserve.to_a.map do |name, count|
        Reservation.new(name, count)
      end.select(&:any?)
    end
  end
end
