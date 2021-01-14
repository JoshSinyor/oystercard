require 'journey'
require 'oystercard'

describe Journey do
  let(:entry_station){ double :entry_station }
  let(:exit_station){ double :exit_station }

  describe 'initialize' do
    it 'initialises with a default #entry_station' do
      expect(subject.entry_station).to eq Journey::DEFAULT_ENTRY_STATION
    end

    it 'accepts a specified #entry_station' do
      card = Oystercard.new
      card.top_up(Oystercard::DEFAULT_MAXIMUM_CARD_VALUE)
      card.touch_in(:entry_station)
      expect(card.journey.entry_station).to eq :entry_station
    end

    it 'accepts a failure to touch_out of the previous journey' do
      card = Oystercard.new
      card.top_up(Oystercard::DEFAULT_MAXIMUM_CARD_VALUE)
      card.touch_in(:entry_station)
      card.touch_in(:entry_station)
      expect(card.journey_history[0].exit_station).to eq nil
    end

    it 'initialises with a nil #exit_station' do
      expect(subject.exit_station).to eq nil
    end

    it { is_expected.to respond_to :fare }
  end

  describe 'complete?' do
    it 'can determine when a journey is not #complete?' do
      card = Oystercard.new
      card.top_up(Oystercard::DEFAULT_MAXIMUM_CARD_VALUE)
      card.touch_in(:entry_station)
      expect(card.in_journey?).to eq true
    end

    it 'can determine when a journey is #complete?' do
      card = Oystercard.new
      card.top_up(Oystercard::DEFAULT_MAXIMUM_CARD_VALUE)
      card.touch_in(:entry_station)
      card.touch_out(:exit_station)
      expect(card.journey_history[0].complete?).to eq true
    end
  end

  describe 'touch_out' do
    it 'accepts a specified #exit_station' do
      card = Oystercard.new
      card.top_up(Oystercard::DEFAULT_MAXIMUM_CARD_VALUE)
      card.touch_in(:entry_station)
      card.touch_out(:exit_station)
      expect(card.journey_history[0].exit_station).to eq :exit_station
    end

    it 'accepts a failure to touch_in to the journey' do
      card = Oystercard.new
      card.touch_out(:exit_station)
      expect(card.journey_history[0].entry_station).to eq nil
    end
  end

  describe 'fare' do
    it 'can charge a default #fare' do
      card = Oystercard.new
      card.top_up(Oystercard::DEFAULT_MAXIMUM_CARD_VALUE)
      card.touch_in(:entry_station)
      expect { card.touch_out(:exit_station) }.to change{ card.balance }.by (- Journey::MINIMUM_FARE)
    end

    it 'can charge a penalty #fare' do
      card = Oystercard.new
      card.top_up(Oystercard::DEFAULT_MAXIMUM_CARD_VALUE)
      expect { card.touch_out(:exit_station) }.to change{ card.balance }.by (- Journey::PENALTY_FARE)
    end
  end
end
