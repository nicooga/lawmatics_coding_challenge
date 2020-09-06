require 'lawyer'

RSpec.describe Lawyer do
  describe 'constructor' do
    it 'takes name and ssn, and generates a unique id automatically' do
      lawyer = described_class.new(name: 'Some Lawyer', ssn: '123')

      expect(lawyer).to have_attributes(
        name: 'Some Lawyer',
        ssn: '123',
        id: be_a(String)
      )
    end
  end

  describe '#cases_by_court' do
  end

  describe '#cases_won' do
  end

  describe '#cases_lost' do
  end

  describe '#profit_from_client' do
  end

  describe '#total_profit' do
  end

  describe '#total_loss' do
  end
end
