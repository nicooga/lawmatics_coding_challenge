require 'client'

RSpec.describe Client do
  describe 'constructor' do
    it 'takes name and ssn' do
      lawyer = described_class.new(name: 'Some Lawyer', ssn: '123')

      expect(lawyer.name).to eq('Some Lawyer')
      expect(lawyer.ssn).to eq('123')
    end
  end
end
