module Entity::UniqueIdMixin
  def self.included(receiver)
    receiver.attr_accessor :id
  end

  def initialize(*args)
    super(*args)
    self.id = SecureRandom.uuid
  end
end
