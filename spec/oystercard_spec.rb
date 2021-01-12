require 'oystercard'

describe Oystercard do
  let(:station){ double :station }
  let(:exit_station){double :exit_station}
  let(:journey){ [{entry_station: station, exit_station: exit_station}] }

  it 'starts with a balance of 0' do
    expect(subject.balance).to eq 0
  end

  describe '#top up' do
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

  describe '#deduct' do
    it 'deducts money from balance' do
      subject.top_up(20)
      expect{ subject.send(:deduct, 20) }.to change{ subject.balance }.by -20
    end
  end

  describe '#in_journey?' do
    it 'starts off not in journey' do
      expect(subject).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it 'tells us that the card is in journey' do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it 'raises an error when the user has insufficient funds' do
      expect(subject.balance).to eq 0
      expect { subject.touch_in(station) }.to raise_error "Insufficient funds"
    end
  end

  describe '#touch_out' do
    it 'tells us that the card is not in journey' do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end

    it 'will deduct the cost of the journey' do
      subject.top_up(10)
      subject.touch_in(station)
      expect { subject.touch_out(exit_station) }.to change{ subject.balance }.by (-Oystercard::DEFAULT_MINIMUM)
    end
  end

  describe '#entry_station' do
    it 'stores the entry station' do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end
  end

  describe '#journeys' do
    it 'has an empty list of journeys by default' do
      expect(subject.journeys).to eq []
    end

    it 'expects a journey to be stored' do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out(exit_station)
      expect(subject.journeys).to eq journey
    end
  end
end
