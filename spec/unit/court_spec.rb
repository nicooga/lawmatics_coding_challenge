require 'court'

RSpec.describe Court do
  describe 'constructor' do
    it 'takes a name, an address and generates a unique id' do
      court = described_class.new(
        name: 'Some Court',
        address: '123 Fake Street'
      )

      expect(court).to have_attributes(
        name: 'Some Court',
        address: '123 Fake Street',
        id: be_a(String)
      )
    end
  end
end
