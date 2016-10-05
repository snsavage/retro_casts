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
    it "calls RetroCasts::CLI.display with No Episodes Found message" do
      expect(RetroCasts::CLI)
        .to receive(:display)
        .with(/No Episodes Found/)
      RetroCasts::CLI.list_episodes(klass.new)
    end
  end
end

