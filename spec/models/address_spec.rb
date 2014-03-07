require 'spec_helper'

describe Address, 'associations' do
  it { expect(subject).to belong_to(:user) }
end

describe Address, 'validations' do
  it { expect(subject).to validate_presence_of(:user_id) }
end

describe '#to_s' do
  it 'displays the addresses address' do
    address = create(:address, address: 'mybEmYUVLX45ReEpXmJDHYKge7xV9Nq8cv')

    expect(address.to_s).to eq 'mybEmYUVLX45ReEpXmJDHYKge7xV9Nq8cv'
  end
end
