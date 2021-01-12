require 'station'

describe Station do

  describe '#initialize' do
    subject = Station.new("Highgate",3)

    it 'has a station name' do
      expect(subject.name).to eq "Highgate"
    end

    it 'has a zone' do
      expect(subject.zone).to eq 3
    end

  end

end
