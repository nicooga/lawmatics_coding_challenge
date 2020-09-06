require 'csv'
require 'court'
require 'lawyer'
require 'client'
require 'court_case'

def consume_csv(name, &block)
  path = File.expand_path("./support/#{name}.csv", File.dirname(__FILE__))

  CSV.foreach(path, col_sep: ';').with_index do |line, index|
    next if index === 0
    block.call(line)
  end
end

describe 'system integration' do
  it 'works' do
    lawyers_by_ssn = {}
    courts_by_id = {}
    clients_by_ssn = {}

    consume_csv(:lawyers) do |line, index|
      ssn, name = line
      lawyers_by_ssn[ssn] = Lawyer.new(ssn: ssn, name: name)
    end

    consume_csv(:courts) do |line, index|
      id, name, address = line
      courts_by_id[id] = Court.new(id: id, name: name, address: address)
    end

    consume_csv(:clients) do |line, index|
      ssn, name = line
      clients_by_ssn[ssn] = Client.new(ssn: ssn, name: name)
    end

    consume_csv(:cases) do |*line, index|
      id, court_id, lawyer_ssn, client_ssn, value, status, date = line

      lawyer = lawyers_by_ssn.fetch(lawyer_ssn)
      client = clients_by_ssn.fetch(client_ssn)
      court = courts_by_id.fetch(court_id)

      court_case = CourtCase.new(
        id: id,
        lawyer: lawyer,
        client: client,
        court: court,
        value: value,
        status: status,
        date: date
      )

      lawyer.court_cases.push(court_case)
    end

    expect(lawyers_by_ssn.fetch('745-11-2147').court_cases.by_court_id('2').count).to eq(5)
    expect(lawyers_by_ssn.fetch('293-64-6251').court_cases.won.count).to eq(4)
    expect(lawyers_by_ssn.fetch('295-62-2630').court_cases.lost.count).to eq(7)
    expect(lawyers_by_ssn.fetch('293-64-6251').court_cases.by_client_ssn('407-02-9374').total_profit).to eq(72350)
    expect(lawyers_by_ssn.fetch('293-64-6251').total_loss).to eq(107165)
  end
end
