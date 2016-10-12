require 'spec_helper'

vcr_default = { cassette_name: "RailsCasts Root", record: :once }
vcr_search = { cassette_name: "RailsCasts Search for Foundation", record: :once }

describe RetroCasts::RailsCasts, vcr: vcr_default do
  let(:klass) { RetroCasts::RailsCasts }
  let(:episode_klass) { RetroCasts::Episode }
  let(:site) { klass.new }
  let(:host) { 'http://www.railscasts.com' }
  let(:filter) { '.episode' }
  let(:page) { 1 }
  let(:search) { '' }

  describe '#new' do
    context 'with a valid host' do
      it 'accepts two arguments' do
        expect(klass).to respond_to(:new).with(4).arguments
        site
      end

      it 'sets a host attribute' do
        expect(site.host).to eq(host)
      end

      it 'sets a filter attribute' do
        expect(site.filter).to eq(filter)
      end

      it 'sets a page attribute' do
        expect(site.page).to eq(page)
      end
      
      it 'sets a search attribute' do
        expect(site.search).to eq(search)
      end

      it 'sets an array of Episodes' do
        expect(site.episodes).to all(be_a(episode_klass))
      end
      
      it 'returns an instance of RetroCasts::RailsCasts' do
        expect(klass.new).to be_an_instance_of(RetroCasts::RailsCasts)
      end

      context 'given url paramters' do
        it 'sets a basic url' do
          skip
        end

        it 'sets a search url' do
          skip
        end

        it 'sets a page url' do
          skip
        end
      end
    end

    context 'with an invalid host' do
      let(:invalid_site) {
        klass.new(host: '')
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

  # describe '#search', vcr: vcr_search do
  #   it 'returns a new list of episodes based on the search term' do
  #     default_site = site
  #     site.search("foundation")
  #     expect(site.episodes.first).to eq(default_site.episodes.first)
  #     expect(site.episodes.length).to eq(1)
  #   end
  # end
end

