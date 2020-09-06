require 'entity'
require 'entity/unique_id_mixin'

class Court < Entity
  include Entity::UniqueIdMixin
  attr_accessor :name, :address
end
