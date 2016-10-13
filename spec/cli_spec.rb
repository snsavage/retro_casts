require 'spec_helper'

vcr_options = { cassette_name: "RailsCasts Root", record: :once }

describe RetroCasts::CLI, vcr: vcr_options do
  let(:klass) { RetroCasts::CLI }
  let(:episodes) { RetroCasts::RailsCasts.new.episodes }

  describe '.welcome' do
    it 'should display a welcome message' do
      expect{klass.welcome}.to output(/Welcome/).to_stdout
    end
  end

  describe '.list_episodes' do
    let(:regex) { /\d+.[\w\s\(\)]+-\s\w{3}\s\d+,\s\d{4}/ }

    context 'with a list of episodes' do
      it 'should display a list number and episode title' do
        expect(klass).to receive(:display).with(regex).exactly(10).times
        klass.list_episodes(episodes)
      end
    end

    context 'the first episode' do
      it 'should display' do
        expect(klass).to receive(:display).with("1. Foundation - Jun 16, 2013").at_least(1).times
        klass.list_episodes(episodes.shift(1))
      end
    end

    context 'with an empty list of episodes' do
      it 'should display No Episodes Found' do
        expect(klass).to receive(:display).with(/No Episodes Found/)
        episodes = RetroCasts::RailsCasts.new(host: '', filter: '').episodes
        klass.list_episodes(episodes)
      end
    end
  end

  describe '.show_episode_detail' do
    context 'with an episode, it displays episode details' do
      let(:episode) {episodes.first}

      it 'calls display for each episode attribute' do
        expect(klass).to receive(:display).with("Title: #{episode.title}")
        expect(klass).to receive(:display).with("Number: #{episode.number}")
        expect(klass).to receive(:display).with("Date: #{episode.date}")
        expect(klass).to receive(:display).with("Length: #{episode.length}")
        expect(klass).to receive(:display).with("Link: #{episode.link}")
        expect(klass).to receive(:display).with("Description: #{episode.description}")

        klass.show_episode_detail(episode)
      end
    end
  end

  describe '.display' do
    context 'with no message' do
      it 'puts an empty string' do
        expect { klass.display }
          .to output("\n")
          .to_stdout
      end
    end

    context 'with a message' do
      it 'puts message' do
        expect { klass.display('message') }
        .to output("message\n")
        .to_stdout
      end
    end
  end
end

