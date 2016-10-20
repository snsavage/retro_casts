require 'spec_helper'

vcr_options = { cassette_name: "RailsCasts Root", record: :once }

describe RetroCasts::Episode, vcr: vcr_options do
  describe 'episode attribute getters' do
    let(:episode) { RetroCasts::RailsCasts.new.episodes.first }

    it {expect(episode.title).to eq("Foundation")}
    it {expect(episode.number).to eq(417)}
    it {expect(episode.date).to eq("Jun 16, 2013")}
    it {expect(episode.length).to eq("11 minutes")}
    it {expect(episode.link).to eq("http://www.railscasts.com/episodes/417-foundation")}
    it {expect(episode.description).to eq("ZURB's Foundation is a front-end for quickly building applications and prototypes. It is similar to Twitter Bootstrap but uses Sass instead of LESS. Here you will learn the basics of the grid system, navigation, tooltips and more.")}
  end
end

