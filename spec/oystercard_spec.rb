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

    it 'Raises an error when exceeds the card limit' do
      default_limit = Oystercard::DEFAULT_LIMIT
      subject.top_up(default_limit)
      expect{ subject.top_up 1 }.to raise_error "It exceeds the #{default_limit} limit."
    end
  end

  describe 'deduct' do
    it 'checks if the oystercard responds to the deduct method' do
      expect(subject).to respond_to(:deduct).with(1).argument
    end

    it 'deducts money from balance' do
      subject.top_up(20)
      expect{ subject.deduct(20) }.to change{ subject.balance }.by -20
    end
  end
end
