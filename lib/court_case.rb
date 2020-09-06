require 'entity'
require 'entity/unique_id_mixin'

class CourtCase < Entity
  include Entity::UniqueIdMixin

  attr_accessor :client, :lawyer, :court, :status, :date, :value

  STATUSES = %i[ongoing lost won]

  def initialize(*args)
    super(*args)
    self.status ||= :ongoing
  end

  def status=(s)
    s = s.to_sym

    unless STATUSES.include?(s)
      raise "Unknown status #{s}. Valid status are: #{STATUSES}" 
    end

    @status = s
  end

  def value=(v)
    @value = v.to_i
  end
end
