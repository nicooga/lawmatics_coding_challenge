require 'securerandom'
require 'person'
require 'entity/unique_id_mixin'

class Lawyer < Person
  include Entity::UniqueIdMixin
end
