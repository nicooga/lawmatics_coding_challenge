# A base class for data holder classes.
# @abstract
class Entity
  def initialize(attributes = {})
    attributes.each do |key, value|
      public_send("#{key}=", value)
    end
  end
end
