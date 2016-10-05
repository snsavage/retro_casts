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
    let(:regex) { /\d+.[\w\s\(\)]+-\s\w{3}\s\d{2},\s\d{4}/ }

    context 'with a list of episodes' do
      it 'should display a list number and episode title' do
        expect(klass).to receive(:display).with(regex).exactly(10).times
        klass.list_episodes(episodes)
      end
    end

    context 'with an empty list of episodes' do
      it 'should display No Episodes Found' do
        expect(klass).to receive(:display).with(/No Episodes Found/)
        episodes = RetroCasts::RailsCasts.new('','').episodes
        klass.list_episodes(episodes)
      end
    end
  end

  describe '.get_episode' do
    it 'takes an integer an returns a corresponding episode' do
      episode = episodes.first
      expect(klass.get_episode(1, episodes)).to eq(episode)
    end

    context 'with an out of range list_number' do
      it 'returns an invalid selection prompt to number range' do
        message = "Invalid selection, please choose a number " +
           "between 1 and #{episodes.length}."
        expect(klass).to receive(:display).with(message).once
        klass.get_episode(20, episodes)
      end

      it 'returns an invalid selection prompt to number range' do
        message = "Invalid selection, please choose a number " +
           "between 1 and #{episodes.length}."
        expect(klass).to receive(:display).with(message).once
        klass.get_episode(-100, episodes)
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

