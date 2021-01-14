require 'oystercard'

describe Oystercard do
  let(:entry_station){ double :entry_station }
  let(:exit_station){double :exit_station}
  let(:journey_history){ [{entry_station: entry_station, exit_station: exit_station}] }

  it 'starts with a balance of 0' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it 'checks if the oystercard responds to the top_up method' do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it 'Adds money to balance' do
      expect{ subject.top_up(50) }.to change{ subject.balance }.by 50
    end

    it 'Raises an error when exceeds the card limit' do
      subject.top_up(Oystercard::DEFAULT_MAXIMUM_CARD_VALUE)
      expect{ subject.top_up 1 }.to raise_error "The maximum card value is £#{Oystercard::DEFAULT_MAXIMUM_CARD_VALUE}"
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
    # it 'tells us that the card is in journey' do
    #  subject.top_up(10)
    #  subject.touch_in(entry_station)
    #  expect(subject).to be_in_journey
    # end

    it 'raises an error when the user has insufficient funds' do
      expect(subject.balance).to eq 0
      expect { subject.touch_in(entry_station) }.to raise_error "Insufficient funds."
    end
  end

  describe '#touch_out' do
    it 'tells us that the card is not in journey' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end

    # it 'will deduct the cost of the journey' do
    #  subject.top_up(10)
    #  subject.touch_in(entry_station)
    #  expect { subject.touch_out(exit_station) }.to change{ subject.balance }.by (-Oystercard::DEFAULT_MINIMUM_CARD_VALUE)
    # end
  end

  describe '#entry_station' do
  #  it 'stores the entry station' do
  #    subject.top_up(10)
  #    subject.touch_in(entry_station)
  #    expect(subject.entry_station).to eq entry_station
  #  end
  end

  describe '#journey_history' do
    it 'has an empty list of journeys by default' do
      expect(subject.journey_history).to eq []
    end

    #it 'expects a journey to be stored' do
    #  subject.top_up(10)
    #  subject.touch_in(entry_station)
    #  subject.touch_out(exit_station)
    #  expect(subject.journey_history).to eq journey
    #end
  end
end
