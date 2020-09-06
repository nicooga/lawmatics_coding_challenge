require 'entity'
require 'entity/unique_id_mixin'

class Person < Entity
  attr_accessor :name, :ssn
end
