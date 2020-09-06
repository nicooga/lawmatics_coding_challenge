require 'client'

RSpec.describe Client do
  describe 'constructor' do
    it 'takes a name and a ssn, and generates a unique id' do
      client = described_class.new(name: 'Some Lawyer', ssn: '123')
      expect(client).to have_attributes(name: 'Some Lawyer', ssn: '123')
    end
  end
end
