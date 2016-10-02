require 'spec_helper'

vcr_rails_casts = { cassette_name: "RailsCasts Root", record: :once }
vcr_web_site = { cassette_name: "RailsCasts Root", record: :once }

describe RetroCasts::Website, vcr: vcr_web_site do
  let(:klass) { RetroCasts::Website }

  describe '.get_list' do
    context 'when given a valid url' do
      let(:url) { 'http://www.railscasts.com' }

      context 'and a valid filter' do
        it 'returns a Nokogiri::XML::NodeSet' do
          site = klass.get_list(url: url, filter: '.episode')
          expect(site).to be_a(Nokogiri::XML::NodeSet)
        end
      end

      context 'and an invalid filter' do
        it 'returns a Nullwebsite' do
          site = klass.get_list(url: url, filter: '')
          expect(site).to be_a(RetroCasts::NullWebsite)
        end
      end
    end

    context 'when given an invalid url' do
      it 'returns a NullWebsite' do
        site = klass.get_list(url: '', filter: '')
        expect(site).to be_a(RetroCasts::NullWebsite)
      end
    end
  end
end


describe RetroCasts::NullWebsite do
  let(:klass) { RetroCasts::NullWebsite }
  describe '.empty?' do
    it 'returns true' do
      expect(klass.new.empty?).to be true
    end
  end
end

describe RetroCasts::RailsCasts, vcr: vcr_rails_casts do
  before (:each) do
    @klass = RetroCasts::RailsCasts
    @episode_klass = RetroCasts::Episode
    @url = 'http://www.railscasts.com/'
  end

  it 'has a HOST' do
    expect(@klass::HOST).to eq(@url)
  end

  it 'has a NODE_SET_FILTER' do
    expect(@klass::NODE_SET_FILTER).to eq('.episode')
  end

  describe '#get_page' do
    let(:site) {@klass.new('http://www.railscasts.com')}

    context 'with a valid url'  do
      it 'returns a nokogiri html document' do
        page = site.send(:get_page)
        expect(page).to be_a(Nokogiri::HTML::Document)
      end
    end

    context 'with an invalid url' do
      it 'returns NullNokogiri' do
        site = @klass.new('')
        page = site.send(:get_page)
        expect(page).to be_a(RetroCasts::NullNokogiri)
      end
    end
  end

  describe '#get_nodeset' do
    context 'with a valid css class' do
      it 'returns a nokogiri xml nodeset' do
        site = @klass.new(@url)
        nodeset = site.send(:get_nodeset)
        expect(nodeset).to be_a(Nokogiri::XML::NodeSet)
      end
    end
  end

  describe '#new' do
    let(:site) do
      @klass.new(@url)
    end

    it 'accepts one argument' do
      expect(@klass).to receive(:new).with(anything)
      @klass.new(@url)
    end

    it 'sets a url attribute' do
      expect(site.url).to eq(@url)
    end

    it 'sets a page attribute to a Nokogiri::HTML::Document' do
      expect(site.page).to be_a(Nokogiri::HTML::Document)
    end

    it 'sets a nodeset to a Nokogiri::XML::NodeSet' do
      expect(site.nodeset).to be_a(Nokogiri::XML::NodeSet)
    end

    it 'returns an array of Episodes' do
      expect(site.send(:parse_episodes)).to all(be_a(@episode_klass))
    end

    context 'with an invalid url' do
      let(:invalid_site) {
        RetroCasts::RailsCasts.new('')
      }

      it {expect(invalid_site.page).to be_a(RetroCasts::NullNokogiri)}
      it {expect(invalid_site.episodes).to eq([])}
    end
  end

  describe '#create_episode' do
    let(:site) do
      @klass.new(@url)
    end

    it 'takes a html episode as an argument and returns a new episode' do
      episode = site.nodeset.first
      expect(site.send(:create_episode, episode)).to be_a(RetroCasts::Episode)
    end
  end

  describe '#parse_episodes' do
    let(:site) {@klass.new(@url)}

    it 'returns an array ' do
      expect(site.send(:parse_episodes)).to be_a(Array)
    end

    it 'returns an array of episodes' do
      expect(site.send(:parse_episodes)).to all(be_a(@episode_klass))
    end
  end

  describe '#episodes' do
    let(:site) {site = RetroCasts::RailsCasts.new('http://www.railscasts.com')}

    it 'returns an array' do
      expect(site.episodes).to be_a(Array)
    end

    it 'returns an array with an instance of Episode' do
      expect(site.episodes).to all(be_an_instance_of(RetroCasts::Episode))
    end
  end

  describe 'Episode' do
    describe 'episode attribute getters' do
      let(:episode) {
        RetroCasts::RailsCasts.new(@url).episodes.first
      }

      it {expect(episode.title).to eq("Foundation")}
      it {expect(episode.number).to eq("Episode #417")}
      it {expect(episode.date).to eq("Jun 16, 2013")}
      it {expect(episode.length).to eq("(11 minutes)")}
      it {expect(episode.link).to eq("/episodes/417-foundation")}
      it {expect(episode.description).to include("ZURB's Foundation is a front-end for quickly building applications and prototypes. It is similar to Twitter Bootstrap but uses Sass instead of LESS. Here you will learn the basics of the grid system, navigation, tooltips and more.")}
    end
  end
end

