require 'lawyer'
require 'court_case'
require 'court'

RSpec.describe Lawyer do
  subject(:lawyer) { described_class.new(name: 'Some Lawyer', ssn: '123') }

  describe 'constructor' do
    it 'takes name and ssn, and generates a unique id automatically' do
      is_expected.to have_attributes(
        name: 'Some Lawyer',
        ssn: '123',
        id: be_a(String)
      )
    end
  end

  describe '#court_cases' do
    it 'allows getting and adding court_cases to the lawyer' do
      court_case = instance_double(CourtCase)
      lawyer.court_cases.push(court_case)
      expect(lawyer.court_cases).to eq([court_case])
    end
  end

  describe '#court_cases.by_court_name' do
    it 'finds court cases with given id' do
      court_case_1 = instance_double(CourtCase, court: instance_double(Court, id: 4))
      court_case_2 = instance_double(CourtCase, court: instance_double(Court, id: 5))

      lawyer.court_cases.push(court_case_1)
      lawyer.court_cases.push(court_case_2)

      expect(lawyer.court_cases.by_court_id(5)).to eq([court_case_2])
    end
  end

  describe '#court_cases.by_court_name' do
    it 'finds court cases with given name' do
      court_case_1 = instance_double(CourtCase, court: instance_double(Court, name: 'Some Court'))
      court_case_2 = instance_double(CourtCase, court: instance_double(Court, name: 'Some Other Court'))

      lawyer.court_cases.push(court_case_1)
      lawyer.court_cases.push(court_case_2)

      expect(lawyer.court_cases.by_court_name('Some Court')).to eq([court_case_1])
    end
  end

  describe '#court_cases.won' do
    it 'finds court cases where status is :won' do
      court_case_1 = instance_double(CourtCase, status: :lost)
      court_case_2 = instance_double(CourtCase, status: :won)

      lawyer.court_cases.push(court_case_1)
      lawyer.court_cases.push(court_case_2)

      expect(lawyer.court_cases.won).to eq([court_case_2])
    end
  end

  describe '#court_cases.lost' do
    it 'finds court cases where status is :lost' do
      court_case_1 = instance_double(CourtCase, status: :lost)
      court_case_2 = instance_double(CourtCase, status: :won)

      lawyer.court_cases.push(court_case_1)
      lawyer.court_cases.push(court_case_2)

      expect(lawyer.court_cases.lost).to eq([court_case_1])
    end
  end

  describe '#court_cases.by_client_ssn(ssn).total_profit' do
    it 'sums the value for all won court cases with client' do
      client_1 = instance_double(Client, ssn: '123')
      client_2 = instance_double(Client, ssn: '234')

      lawyer.court_cases.push(instance_double(CourtCase, client: client_1, status: :won, value: 1500))
      lawyer.court_cases.push(instance_double(CourtCase, client: client_1, status: :lost, value: 2000))
      lawyer.court_cases.push(instance_double(CourtCase, client: client_1, status: :won, value: 3000))
      lawyer.court_cases.push(instance_double(CourtCase, client: client_2, status: :won, value: 4000))
      lawyer.court_cases.push(instance_double(CourtCase, client: client_2, status: :lost, value: 5000))

      expect(lawyer.court_cases.by_client_ssn('123').total_profit).to eq(4500)
    end
  end

  describe '#total_profit' do
    it 'sums the value for all won court cases' do
      client_1 = instance_double(Client)
      client_2 = instance_double(Client)

      lawyer.court_cases.push(instance_double(CourtCase, client: client_1, status: :won, value: 1500))
      lawyer.court_cases.push(instance_double(CourtCase, client: client_1, status: :lost, value: 2000))
      lawyer.court_cases.push(instance_double(CourtCase, client: client_1, status: :won, value: 3000))
      lawyer.court_cases.push(instance_double(CourtCase, client: client_2, status: :won, value: 4000))
      lawyer.court_cases.push(instance_double(CourtCase, client: client_2, status: :lost, value: 5000))

      expect(lawyer.total_profit).to eq(8500)
    end
  end

  describe '#total_loss' do
    it 'sums the value for all lost court cases' do
      client_1 = instance_double(Client)
      client_2 = instance_double(Client)

      lawyer.court_cases.push(instance_double(CourtCase, client: client_1, status: :won, value: 1500))
      lawyer.court_cases.push(instance_double(CourtCase, client: client_1, status: :lost, value: 2000))
      lawyer.court_cases.push(instance_double(CourtCase, client: client_1, status: :won, value: 3000))
      lawyer.court_cases.push(instance_double(CourtCase, client: client_2, status: :won, value: 4000))
      lawyer.court_cases.push(instance_double(CourtCase, client: client_2, status: :lost, value: 5000))

      expect(lawyer.total_loss).to eq(7000)
    end
  end
end
