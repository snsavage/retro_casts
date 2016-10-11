require 'spec_helper'

vcr_options = { cassette_name: "RailsCasts Root", record: :once }

describe RetroCasts::RailsCasts, vcr: vcr_options do
  let(:klass) { RetroCasts::RailsCasts }
  let(:episode_klass) { RetroCasts::Episode }
  let(:site) { klass.new }
  let(:url) { 'http://www.railscasts.com' }
  let(:filter) { '.episode' }

  describe '#new' do
    context 'with a valid url' do
      it 'accepts two arguments' do
        expect(klass).to respond_to(:new).with(2).arguments
        site
      end

      it 'sets a url attribute' do
        expect(site.url).to eq(url)
      end

      it 'sets a filter attribute' do
        expect(site.filter).to eq(filter)
      end

      it 'returns an array of Episodes' do
        expect(site.episodes).to all(be_a(episode_klass))
      end
    end

    context 'with an invalid url' do
      let(:invalid_site) {
        klass.new('')
      }

      it 'returns an empty array' do
        expect(invalid_site.episodes).to eq([])
      end
    end
  end

  describe '#episodes' do
    it 'returns an array' do
      expect(site.episodes).to be_a(Array)
    end

    it 'returns an array with an instance of Episode' do
      expect(site.episodes).to all(be_a(episode_klass))
    end
  end

  describe '#episode?' do
    context 'when provided with a valid number returns true' do
      it { expect(site.episode?(1)).to be true }
      it { expect(site.episode?(10)).to be true }
    end

    context 'when provided with an invalid number returns false' do
      it { expect(site.episode?(0)).to be false }
      it { expect(site.episode?(11)).to be false }
      it { expect(site.episode?(-1)).to be false }
      it { expect(site.episode?(100)).to be false }
    end
  end
    
  describe '#episode' do
    it 'returns an episode based on human readable indexing' do
      expect(site.episode(1)).to eq(site.episodes.first)
    end

    it 'returns nil for an invalid episode selection' do
      expect(site.episode(0)).to be nil
    end
  end
end

