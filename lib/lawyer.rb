require 'forwardable'
require 'securerandom'
require 'person'
require 'entity/unique_id_mixin'

class Lawyer < Person
  extend Forwardable
  include Entity::UniqueIdMixin

  def_delegators :court_cases, :total_profit, :total_loss

  def court_cases=(array)
    self.court_cases = CourtCases.new(array)
  end

  def court_cases
    @court_cases ||= self.class::CourtCases.new
  end

  class CourtCases < Array
    def by_court_name(name)
      self.class.new(filter { |court_case| court_case.court.name === name })
    end

    def by_court_id(id)
      self.class.new(filter { |court_case| court_case.court.id === id })
    end

    def won
      by_status(:won)
    end

    def lost
      by_status(:lost)
    end

    def total_profit
      by_status(:won).sum(&:value)
    end

    def total_loss
      by_status(:lost).sum(&:value)
    end

    def by_client_ssn(ssn)
      self.class.new(filter { |cc| cc.client.ssn === ssn})
    end

    def by_status(s)
      self.class.new(filter { |cc| cc.status === s })
    end
  end
end
