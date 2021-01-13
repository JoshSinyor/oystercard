require 'journey_2'
require 'oystercard'

describe Journey_2 do
  let(:entry_station){ double :entry_station }


    it 'accepts an entry station' do
      card = Oystercard.new
      card.top_up(10)
      card.touch_in(:entry_station)
      puts card
    end

  describe "#initialize" do

    it 'has a default entry station' do
      expect(subject.entry_station).to eq Journey_2::DEFAULT_ENTRY_STATION
    end

    it 'has a custom entry station' do
      card = Oystercard.new
      card.top_up(10)
      card.touch_in("Highgate")

      # Card methods = generating a card
      # Card is being passed to journey_2.rb
      # We are querying journey_2.rb instance

      # We are querying a new instance of journey_2.rb
    end

  end

  describe '#finish' do

  end

  describe '#fare' do

  end

  describe '#complete?' do

  end







end
