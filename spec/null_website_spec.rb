require 'spec_helper'

describe RetroCasts::NullWebsite do
  let(:klass) { RetroCasts::NullWebsite }
  describe '.empty?' do
    it 'returns true' do
      expect(klass.new.empty?).to be true
    end
  end
end

