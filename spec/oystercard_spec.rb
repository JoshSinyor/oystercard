require "oystercard"

describe Oystercard do

  it 'starts with a balance of 0' do
    expect(subject.balance).to eq 0
  end

  describe 'top up' do
    it 'checks if the oystercard responds to the top_up method' do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it 'Adds money to balance' do
      expect{ subject.top_up(50) }.to change{ subject.balance }.by 50
    end
  end
end
