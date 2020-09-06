require 'court_case'
require 'client'
require 'lawyer'
require 'court'

RSpec.describe CourtCase do
  describe 'constructor' do
    it 'takes a client, lawyer, a date and a case value' do
      client = instance_double(Client)
      lawyer = instance_double(Lawyer)
      court = instance_double(Court)
      date = Time.now

      court_case = described_class.new(
        id: 3,
        client: client,
        lawyer: lawyer,
        court: court,
        date: date,
        value: '1000'
      )

      expect(court_case).to have_attributes(
        id: 3,
        client: client,
        lawyer: lawyer,
        court: court,
        date: date,
        value: 1000,
        status: :ongoing
      )
    end

    describe 'when status is valid' do
      it 'raises an error' do
        %i[ongoing lost won].each do |status|
          expect { described_class.new(status: status) }.not_to raise_error
        end
      end
    end

    describe 'when status is not valid' do
      it 'raises an error' do
        expect { described_class.new(status: :some_invalid_status) }.to raise_error(
          RuntimeError,
          'Unknown status some_invalid_status. Valid status are: [:ongoing, :lost, :won]'
        )
      end
    end
  end
end
