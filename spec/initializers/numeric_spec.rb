require 'spec_helper'

describe Numeric, '#to_satoshis' do
  it 'converts a number to satoshis' do
    expect(21.to_satoshis).to eq 2_100_000_000
  end
end

describe Numeric, '#to_millibit_satoshis' do
  it 'converts a number to satoshis' do
    expect(21.to_millibit_satoshis).to eq 2_100_000
  end
end

describe String, '#is_number?' do
  it 'is true if the string is a number' do
    expect('21.08'.is_number?).to eq true
  end

  it 'is false otherwise' do
    expect('boom pop'.is_number?).to eq false
  end
end

describe String, '#to_satoshis' do
  it 'converts a number to satoshis' do
    expect('21'.to_satoshis).to eq 2_100_000_000
  end
end

describe String, '#to_millibit_satoshis' do
  it 'converts a number to satoshis' do
    expect('21'.to_millibit_satoshis).to eq 2_100_000
  end
end
