require 'spec_helper'

describe RetroCasts::NullWebsite do
  let(:klass) { RetroCasts::NullWebsite }
  describe '.empty?' do
    it 'returns true' do
      expect(klass.new.empty?).to be true
    end
  end

  describe '.collect' do
    it 'returns self' do
      obj = klass.new
      expect(obj.collect).to eq(obj)
    end
  end

  describe '.each_with_index' do
    it "calling list_episodes on NullWebsite instance displays message" do
      expect(RetroCasts)
        .to receive(:display)
        .with(/No Episodes Found/)
        RetroCasts::RailsCasts.new(host: '', filter: '').list_episodes
    end

    it "calling list_episodes on NullWebsite instance displays message" do
      skip
      expect(RetroCasts)
        .to receive(:display)
        .with(/No Episodes Found/)
        RetroCasts::RailsCasts.new(host: '').list_episodes
    end
  end
end

