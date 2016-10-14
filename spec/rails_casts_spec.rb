require 'spec_helper'

vcr_default = { cassette_name: "RailsCasts Root", record: :once }
vcr_search = { cassette_name: "RailsCasts Search", record: :once }
vcr_page = { cassette_name: "RailsCasts Page", record: :once }
vcr_page_search = { cassette_name: "RailsCasts Page & Search", record: :once }

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
        expect(site.page).to eq 1
      end
      
      it 'sets a search attribute' do
        expect(site.search).to be nil
      end

      it 'sets an array of Episodes' do
        expect(site.episodes).to all(be_a(episode_klass))
      end

      it 'set a url attribute' do
        expect(site.url).to_not be nil
      end
      
      it 'returns an instance of RetroCasts::RailsCasts' do
        expect(klass.new).to be_an_instance_of(RetroCasts::RailsCasts)
      end

      context 'given url paramters' do
        it 'sets a basic url' do
          expect(klass.new.url).to eq("http://www.railscasts.com/")
        end

        it 'sets a search url', vcr: vcr_search do
          expect(klass.new(search: "model caching").url).to eq("http://www.railscasts.com/episodes?search=model+caching")
        end

        it 'sets a page url', vcr: vcr_page do
          expect(klass.new(page: 2).url).to eq("http://www.railscasts.com/?page=2")
        end
        
        it 'sets a page and search url', vcr: vcr_page_search do
          expect(klass.new(page: 2, search: "production").url).to eq("http://www.railscasts.com/episodes?search=production&page=2")
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

  describe '#get_search' do
    let(:search_site) {
      VCR.use_cassette("RailsCasts Search") do
        site.get_search("model caching")
      end
    }

    it 'returns a new instance of RailsCasts based on search term' do
      expect(search_site).to be_an_instance_of(klass)
    end

    it 'search site has a list of 9 episodes' do
      expect(search_site.episodes.length).to eq 4
    end
  end

  describe '#next_page' do
    skip
  end

  describe '#prev_page' do
    skip
  end

  describe '#list_episodes' do
    let(:regex) { /\d+.[\w\s\(\)]+-\s\w{3}\s\d+,\s\d{4}/ }

    context 'with a list of episodes' do
      it 'should display a list number and episode title' do
        expect(RetroCasts).to receive(:display).with(regex).exactly(10).times
        site.list_episodes
      end
    end

    context 'the first episode' do
      it 'should display' do
        expect(RetroCasts).to receive(:display).with("1. Foundation - Jun 16, 2013").at_least(1).times
        allow(RetroCasts).to receive(:display).at_least(:once)
        site.list_episodes
      end
    end

    context 'with an empty list of episodes' do
      it 'should display No Episodes Found' do
        expect(RetroCasts).to receive(:display).with(/No Episodes Found/)
        null_site = RetroCasts::RailsCasts.new(host: '', filter: '')
        null_site.list_episodes
      end
    end
  end

  describe '#show_episode_detail' do
    context 'with an episode, it displays episode details' do
      let(:episode_number) { 1 }
      let(:episode) { site.episode(episode_number) }
      let(:cli) { RetroCasts::CLI }

      it 'calls display for each episode attribute' do
        expect(cli).to receive(:display).with("Title: #{episode.title}")
        expect(cli).to receive(:display).with("Number: #{episode.number}")
        expect(cli).to receive(:display).with("Date: #{episode.date}")
        expect(cli).to receive(:display).with("Length: #{episode.length}")
        expect(cli).to receive(:display).with("Link: #{episode.link}")
        expect(cli).to receive(:display).with("Description: #{episode.description}")

        site.show_episode_detail(episode_number)
      end
    end
  end
end

