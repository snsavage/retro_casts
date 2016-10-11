require 'spec_helper'

describe RetroCasts do
  it 'has a version number' do
    expect(RetroCasts::VERSION).not_to be nil
  end

  describe 'integer?' do
    it { expect(RetroCasts.send(:integer?, 1)).to be true }
    it { expect(RetroCasts.send(:integer?, "String")).to be false }
  end
end


