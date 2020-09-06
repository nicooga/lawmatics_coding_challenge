require 'client'

RSpec.describe Client do
  describe 'constructor' do
    it 'takes name and ssn' do
      client = described_class.new(name: 'Some Lawyer', ssn: '123')

      expect(client.name).to eq('Some Lawyer')
      expect(client.ssn).to eq('123')
    end
  end
end
