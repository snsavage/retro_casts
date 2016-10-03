require 'spec_helper'

vcr_options = { cassette_name: "RailsCasts Root", record: :once }

describe RetroCasts::NullWebsite do
  let(:klass) { RetroCasts::NullWebsite }
  describe '.empty?' do
    it 'returns true' do
      expect(klass.new.empty?).to be true
    end
  end
end

describe RetroCasts::Episode, vcr: vcr_options do
  describe 'episode attribute getters' do
    let(:episode) { RetroCasts::RailsCasts.new.episodes.first }

    it {expect(episode.title).to eq("Foundation")}
    it {expect(episode.number).to eq("Episode #417")}
    it {expect(episode.date).to eq("Jun 16, 2013")}
    it {expect(episode.length).to eq("(11 minutes)")}
    it {expect(episode.link).to eq("/episodes/417-foundation")}
    it {expect(episode.description).to include("ZURB's Foundation is a front-end for quickly building applications and prototypes. It is similar to Twitter Bootstrap but uses Sass instead of LESS. Here you will learn the basics of the grid system, navigation, tooltips and more.")}
  end
end

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
end

