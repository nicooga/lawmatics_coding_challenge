require 'entity'
require 'securerandom'

class Lawyer < Entity
  attr_accessor :name, :ssn, :id

  def initialize(*args)
    super(*args)
    self.id = SecureRandom.uuid
  end
end
