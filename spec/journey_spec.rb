require 'journey'
require 'oystercard'

describe Journey do
  let(:entry_station){ double :entry_station }

  describe "initialize" do

    it 'has a default entry station' do
      expect(subject.entry_station).to eq Journey::DEFAULT_ENTRY_STATION
    end

    it 'has a default exit station' do
      expect(subject.exit_station).to eq Journey::DEFAULT_EXIT_STATION
    end

    it 'accepts an entry station' do
      card = Oystercard.new
      card.top_up(10)
      card.touch_in(:entry_station)
      expect(card.journey.entry_station).to eq :entry_station
    end

  end

  describe '#finish' do
  end

  describe '#fare' do
  end

  describe '#complete?' do
  end

end
