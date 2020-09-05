require 'lawyer'

RSpec.describe Lawyer do
  describe 'constructor' do
    it 'takes name and ssn, and generates a unique id automatically' do
      lawyer = described_class.new(name: 'Some Lawyer', ssn: '123')

      expect(lawyer.name).to eq('Some Lawyer')
      expect(lawyer.ssn).to eq('123')
      expect(lawyer.id).to be_a(String)
    end
  end
end
